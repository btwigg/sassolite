require 'test_helper'

class StatusUpdateTest < ActiveSupport::TestCase
  
  context "A StatusUpdate" do
    setup do
      @status_update = Factory.create(:status_update)
    end
    
    should belong_to :user
    should belong_to :project_duration
    should validate_presence_of :entry_date
    should validate_uniqueness_of(:entry_date).scoped_to(:project_duration_id)
    should validate_presence_of :description    
    
    context "by default" do
      should "have a status of open" do
        assert_equal "open", @status_update.state
      end
    end
    
    context "on lock" do
      setup do
        @status_update.lock!
      end
      
      should "have a status of locked" do
        assert_equal "locked", @status_update.state
      end
    end
    
    context "that is locked and is reopened" do
      setup do
        @status_update.state = "locked"
        @status_update.reopen!
      end
      
      should "have a status of open" do
        assert_equal "open", @status_update.state
      end
    end
  end
  
end
