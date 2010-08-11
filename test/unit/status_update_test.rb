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
  end
  
end
