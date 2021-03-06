require 'test_helper'

class ProjectDurationTest < ActiveSupport::TestCase
  
  context "A ProjectDuration" do
    setup do
      @project_duration = Factory.create(:project_duration)
      @project = @project_duration.project
    end
    
    should belong_to :project
    should have_many :status_updates
    
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
    
    context "that is after an existing duration for a project" do
      setup do
        @duration = @project_duration.clone
        @duration.start = @project_duration.end + 1.day
        @duration.end = @project_duration.end + 1.week
        @duration.valid?
      end
      
      should "be valid" do
        assert ! @duration.errors.has_key?(:base)
      end
    end
    
    context "that overlaps with an existing duration for a project" do
      setup do
        @duration = @project_duration.clone
        @duration.start = @project_duration.end
        @duration.end = @project_duration.end + 1.week
        @duration.valid?
      end
      
      should "not be valid" do
        assert @duration.errors.has_key?(:base)
      end
    end
    
    context "looking for a status update on a specific date" do
      context "where that date falls into the current range" do
        setup do
          @status_update1 = Factory.create(:status_update, :project_duration => @project_duration, :entry_date => Date.today - 0, :description => "lorem", :user => @user)
          @status_update2 = Factory.create(:status_update, :project_duration => @project_duration, :entry_date => Date.today - 1, :description => "lorem", :user => @user)
          @status_update3 = Factory.create(:status_update, :project_duration => @project_duration, :entry_date => Date.today - 2, :description => "lorem", :user => @user)
        end
        
        should "return the current duration" do
          assert_equal @status_update1, @project_duration.update_for(Date.today)
        end
      end
      
      context "where that date falls after the last duration" do
        setup do
          @status_update1 = Factory.create(:status_update, :project_duration => @project_duration, :entry_date => Date.today - 1, :description => "lorem", :user => @user)
          @status_update2 = Factory.create(:status_update, :project_duration => @project_duration, :entry_date => Date.today - 2, :description => "lorem", :user => @user)
          @status_update3 = Factory.create(:status_update, :project_duration => @project_duration, :entry_date => Date.today - 3, :description => "lorem", :user => @user)
        end
        
        should "return the current duration" do
          assert_equal @status_update1, @project_duration.update_for(Date.today)
        end
      end
    end
    
  end
  
end
