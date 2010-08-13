require 'test_helper'

class ProjectNumberTest < ActiveSupport::TestCase
  
  context "A ProjectNumber" do
    setup do
      Factory.create(:project_number)
    end
    
    should "generate a new identifier" do
      assert_equal 5960, ProjectNumber.next_code!
    end
  end
  
end
