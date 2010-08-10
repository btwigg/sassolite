require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  context "A Project" do
    setup do
      @project = Factory.create(:project)
    end
    
    should belong_to :project_manager
    should belong_to :client
    should belong_to :project_type
    should have_many :project_durations
    
    should validate_uniqueness_of :code
    should validate_presence_of :code
    should validate_uniqueness_of :name
    should validate_presence_of :name
    
    context "by default" do
      should "have a status of open" do
        assert_equal "open", @project.state
      end
    end
    
    context "on retire" do
      setup do
        @project.retire!
      end
      
      should "have a status of retired" do
        assert_equal "retired", @project.state
      end
    end
    
    context "that is retired and is reopened" do
      setup do
        @project.state = "retired"
        @project.reopen!
      end
      
      should "have a status of open" do
        assert_equal "open", @project.state
      end
    end
    
  end
  
end
