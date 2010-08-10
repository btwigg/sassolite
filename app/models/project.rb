class Project < ActiveRecord::Base
  include ::Transitions
  include ActiveRecord::Transitions
  
  belongs_to :client
  belongs_to :project_manager, :class_name => "User"
  belongs_to :project_type
  
  has_many :project_durations
  
  validates :name, :presence => true, :uniqueness => true
  validates :code, :presence => true, :uniqueness => true
  
  state_machine do
    state :open # first one is initial state
    state :retired

    event :retire do
      transitions :to => :retired, :from => [:open]
    end
    event :reopen do
      transitions :to => :open, :from => [:retired]
    end
  end
end
