class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :managed_projects, :class_name => "Project", :foreign_key => "project_manager_id"
end
