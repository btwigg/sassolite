class StatusUpdate < ActiveRecord::Base
  include ::Transitions
  include ActiveRecord::Transitions
  
  belongs_to :user
  belongs_to :project_duration

  validates :entry_date, :presence => true, :uniqueness => {:scope => :project_duration_id}
  validates :description, :presence => true
  
  state_machine do
    state :open # first one is initial state
    state :locked

    event :lock do
      transitions :to => :locked, :from => [:open]
    end
    event :reopen do
      transitions :to => :open, :from => [:locked]
    end
  end
end
