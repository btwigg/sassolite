require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  context "A Project" do
    setup do
      @project = Factory.create(:project)
    end
    
    should belong_to :project_manager
    should belong_to :client
    should belong_to :project_type
    
    should validate_uniqueness_of :code
    should validate_presence_of :code
    should validate_uniqueness_of :name
    should validate_presence_of :name
  end
  
end
