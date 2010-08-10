class ProjectDuration < ActiveRecord::Base    
  belongs_to :project
  
  validates :start, :presence => true
  validates :end, :presence => true
  validates_with DurationValidator
  
  scope :past, where(["end < ?", Date.today])
  scope :current, where(["start <= ? AND end >= ?", Date.today, Date.today])
end
