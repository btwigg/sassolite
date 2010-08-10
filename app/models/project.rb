class Project < ActiveRecord::Base
  belongs_to :client
  belongs_to :project_manager, :class_name => "User"
  belongs_to :project_type
  
  validates :name, :presence => true, :uniqueness => true
  validates :code, :presence => true, :uniqueness => true
end
