require 'test_helper'

class ProjectTypeTest < ActiveSupport::TestCase
  context "A ProjectType" do
    setup do
      @project_type = Factory.create(:project_type)
    end
    
    should have_many :projects
    
    should validate_uniqueness_of :name
    should validate_presence_of :name
  end
end
