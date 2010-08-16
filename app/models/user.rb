require 'md5'

class User < ActiveRecord::Base
  include ::Transitions
  include ActiveRecord::Transitions
  
  acts_as_authentic
  
  has_many :managed_projects, :class_name => "Project", :foreign_key => "project_manager_id"
  
  validates :email, :presence => true, :uniqueness => true
  validates :initials, :presence => true, :uniqueness => true
  validates :name, :presence => true, :uniqueness => true
  
  scope :disabled, where(:state => "disabled")
  scope :enabled, where(:state => "enabled")
  
  state_machine do
    state :enabled # first one is initial state
    state :disabled

    event :disable do
      transitions :to => :disabled, :from => [:enabled]
    end
    event :enable do
      transitions :to => :enabled, :from => [:disabled]
    end
  end
   
  def generate_random_password
    self.password = self.password_confirmation = Digest::MD5.hexdigest(self.login.to_s + Time.now.to_s)[0..8]
  end
  
  def generate_random_password!
    self.generate_random_password
    self.save
  end
end
