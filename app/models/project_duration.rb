class ProjectDuration < ActiveRecord::Base    
  belongs_to :project
  
  validates :start, :presence => true
  validates :end, :presence => true
  validates_with DurationValidator
end
