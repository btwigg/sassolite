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
    should have_many(:status_updates).through(:project_durations)
    
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
    
    context "looking for a duration on a specific date" do
      context "where that date falls into the current range" do
        setup do
          @project_duration1 = Factory.create(:project_duration, :project => @project, :start => Date.today - 1, :end => Date.today + 1)
          @project_duration2 = Factory.create(:project_duration, :project => @project, :start => Date.today - 2, :end => Date.today - 1)
          @project_duration3 = Factory.create(:project_duration, :project => @project, :start => Date.today - 3, :end => Date.today - 2)
        end
        
        should "return the current duration" do
          assert_equal @project_duration1, @project.duration_for(Date.today)
        end
      end
      
      context "where that date falls after the last duration" do
        setup do
          @project_duration1 = Factory.create(:project_duration, :project => @project, :start => Date.today - 2, :end => Date.today - 1)
          @project_duration2 = Factory.create(:project_duration, :project => @project, :start => Date.today - 3, :end => Date.today - 2)
          @project_duration3 = Factory.create(:project_duration, :project => @project, :start => Date.today - 4, :end => Date.today - 3)
        end
        
        should "return the current duration" do
          assert_equal @project_duration1, @project.duration_for(Date.today)
        end
      end
    end
    
  end
  
end
