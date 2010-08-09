ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "authlogic/test_case"
require "shoulda/rails"
require "paperclip/matchers/have_attached_file_matcher"

Factory.find_definitions

class ActiveSupport::TestCase
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  #fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
   setup :activate_authlogic
end

# Test helpers
def create_user
  # Creating our user automatically logs them in
  @user = Factory.create(:user)
  
  # Manually destroy it
  UserSession.find.destroy
end

def should_redirect_home
  should redirect_to("home") { new_user_session_path }
end