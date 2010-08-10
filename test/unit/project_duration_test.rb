require 'test_helper'

class ProjectDurationTest < ActiveSupport::TestCase
  
  context "A ProjectDuration" do
    setup do
      @project_duration = Factory.create(:project_duration)
    end
    
    should belong_to :project
    
    should validate_presence_of :start
    should validate_presence_of :end
    
    context "with a start date" do
      
      context "before the end date" do
        setup do
          @project_duration.start = Time.now - 1.week
          @project_duration.end = Time.now + 1.week
          @project_duration.valid?
        end
        
        should "be valid" do
          assert ! @project_duration.errors.has_key?(:start)
        end
      end
      
      context "after or equal to the end date" do
        setup do
          time = Time.now
          @project_duration.start = time
          @project_duration.end = time
          @project_duration.valid?
        end
        
        should "not be valid" do
          assert @project_duration.errors.has_key?(:start)
        end
      end
      
    end
    
    context "with several durations for a project" do
      setup do
        @project = @project_duration.project

        @old_project1 = @project_duration.clone
        @old_project1.start = Time.now - 3.months
        @old_project1.end = Time.now - 2.months
        @old_project1.save

        @old_project2 = @project_duration.clone
        @old_project2.start = Time.now - 2.months
        @old_project2.end = Time.now - 1.month
        @old_project2.save
      end

      should "have 1 current duration" do
        assert_equal 1, @project.project_durations.current.count
      end

      should "have 2 past durations" do
        assert_equal 2, @project.project_durations.past.count
      end

    end
    
  end
  
end
