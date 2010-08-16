require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # since authlogic is well tested, there is no need to duplicate it here
  # add additional functionality  
  context "A User" do
    setup do
      @user = Factory.create(:user)
    end

    should have_many :managed_projects
    
    should validate_presence_of :name
    should validate_presence_of :initials
    should validate_presence_of :email
    should validate_uniqueness_of :name
    should validate_uniqueness_of :initials
    should validate_uniqueness_of :email
    
    context "by default" do
      should "have a status of enabled" do
        assert_equal "enabled", @user.state
      end
    end

    context "on disable" do
      setup do
        @user.disable!
      end
  
      should "have a status of disabled" do
        assert_equal "disabled", @user.state
      end
    end

    context "that is disabled and is enableed" do
      setup do
        @user.state = "disabled"
        @user.enable!
      end
  
      should "have a status of enabled" do
        assert_equal "enabled", @user.state
      end
    end
    
  end
  
end
