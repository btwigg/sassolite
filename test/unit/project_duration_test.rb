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
    
  end
  
end
