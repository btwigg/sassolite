class StatusUpdate < ActiveRecord::Base
  belongs_to :user
  belongs_to :project_duration

  validates :entry_date, :presence => true, :uniqueness => {:scope => :project_duration_id}
  validates :description, :presence => true
end
