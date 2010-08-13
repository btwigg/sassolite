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
  login_user
  
  # Manually destroy it
  UserSession.find.destroy
end

def login_user
  @user = Factory.create(:user)  
end

# Shoulda macros
def should_redirect_home
  should redirect_to("home") { new_user_session_path }
end

def should_display_a_form
  should "display a form" do
    assert_select "form"
  end
end

def should_display_a_breadcrumb
  should "display a breadcrumb" do
    assert_select "div#breadcrumb"
  end
end

def should_display_an_error_message
  should "display an error message" do
    assert_select "div.errorExplanation"
  end
end

def should_display_a_headline(headline)
  should "display '#{headline}' headline" do
    assert_select "h2", /#{headline}/
  end
end