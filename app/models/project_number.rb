class ProjectNumber < ActiveRecord::Base
  
  def self.next_code!
    project_number = self.first
    project_number.increment!(:code)
    project_number.code
  end
  
end
