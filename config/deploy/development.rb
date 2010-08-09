set :application, "sassolite"

# Set server information
role :web, "127.0.0.1"
role :app, "127.0.0.1"
role :db, "127.0.0.1", :primary => true