class Project < ActiveRecord::Base
  include ::Transitions
  include ActiveRecord::Transitions
  
  belongs_to :client
  belongs_to :project_manager, :class_name => "User"
  belongs_to :project_type
  
  has_many :project_durations
  has_many :status_updates, :through => :project_durations
  
  validates :name, :presence => true, :uniqueness => true
  validates :code, :presence => true, :uniqueness => true
  
  scope :open, where(:state => "open")
  scope :retired, where(:state => "retired")
  
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
  
  def duration_for(date = Date.today)
    self.project_durations.where(["start <= ? AND end >= ?", date, date]).first ||
    self.project_durations.where(["end < ?", date]).first
  end
end
