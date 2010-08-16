class ProjectDuration < ActiveRecord::Base    
  default_scope :order => 'end DESC'
  
  belongs_to :project
  has_many :status_updates
  
  validates :start, :presence => true
  validates :end, :presence => true
  validates_with DurationValidator
  validates_with ActiveDurationValidator
  
  scope :past, where(["end < ?", Date.today])
  scope :current, where(["start <= ? AND end >= ?", Date.today, Date.today])
  
  def update_for(date = Date.today)
    self.status_updates.where(:entry_date => date).first || self.status_updates.where(["entry_date < ?", date]).first
  end
end
