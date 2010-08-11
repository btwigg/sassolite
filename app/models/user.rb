require 'md5'

class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :managed_projects, :class_name => "Project", :foreign_key => "project_manager_id"
   
  def generate_random_password
    self.password = self.password_confirmation = Digest::MD5.hexdigest(self.login.to_s + Time.now.to_s)[0..8]
  end
  
  def generate_random_password!
    self.generate_random_password
    self.save
  end
end
