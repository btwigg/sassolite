require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # since authlogic is well tested, there is no need to duplicate it here
  # add additional functionality  
  context "A User" do
    setup do
      @user = Factory.create(:user)
    end

    should have_many :managed_projects
  end
  
end
