require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  
  context "A UserMailer" do
    setup do
      @user = Factory.create(:user)
      @email = UserMailer.password_reset(@user, "testPassword")
    end
    
    should "assign user to email" do
      assert_equal [@user.email], @email.to
    end
    
    should "inform the user their password has been reset in the subject" do
      assert_equal "Your Password Has Been Reset", @email.subject
    end
    
    should "contain the username and new password in the email body" do
      assert_match /Your password for account '#{@user.login}' has been reset to 'testPassword'/, @email.encoded
    end
    
  end
  
end
