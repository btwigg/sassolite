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
    
    context "with an email" do 
      context "that is valid" do
        setup do
          @user.email = "test.user@example.org"
          @user.valid?
        end
        
        should "have no errors on email" do
          assert ! @user.errors.has_key?(:email)
        end
      end
      
      context "that is invalid" do
        setup do
          @user.email = "test.user@example##"
          @user.valid?
        end
        
        should "have errors on email" do
          assert @user.errors.has_key?(:email)
        end
      end
    end
  end
  
end
