require 'rubygems'
require 'capistrano/ext/multistage'

# Set multistage with default to dev environment
set :stages, %w(development)
set :default_stage, "development"

# Set repository info
set :scm, :git
set :repository,  ""

# Set deployment method to rsync - much faster than default
set :deploy_via, :rsync_with_remote_cache
# Location is set in a lamdba since our stage file will have the application name
set(:deploy_to)  { "/var/www/apps/#{application}" }

# Set deployment user
set :use_sudo, false
set :user, "deploy"
default_run_options[:pty] = true

after "deploy:update_code", "symlink:config"
after "deploy:update_code", "symlink:sqlite"
after 'deploy:update_code', 'bundler:bundle_new_release'
after "deploy:update_code", "deploy:migrate"

# Restart passenger after deployment
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end

namespace(:symlink) do
  task :config, :roles => :app do
    %w(database couchdb).each do |conf|
      run <<-CMD
        ln -nfs #{shared_path}/config/#{conf}.yml #{release_path}/config/#{conf}.yml
      CMD
    end
  end
  
  task :sqlite, :roles => :app do
    %w(production).each do |db|
      run <<-CMD
        ln -nfs #{shared_path}/db/#{db}.sqlite3 #{release_path}/db/#{db}.sqlite3
      CMD
    end
  end
end

namespace :bundler do
  # task :create_symlink, :roles => :app do
  #   shared_dir = File.join(shared_path, 'bundle')
  #   release_dir = File.join(current_release, '.bundle')
  #   run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  # end
  #  
  task :bundle_new_release, :roles => :app do
    # bundler.create_symlink
    run "cd #{release_path} && bundle install .bundle --without test"
  end
end
 
