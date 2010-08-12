require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  
  context "A UserSessionsController" do
    setup do
      create_user
    end
    
    context "on GET to #new" do
      setup do
        get :new
      end
      
      should respond_with(:success)
      should render_template :new
      
      should "display a link to password reset" do
        assert_select "a", /Password Reset/
      end
    end
    
    context "on POST to #create" do
      
      context "with valid user credentials" do
        setup do
          post :create, :user_session => { :login => "sampleUser", :password => "password"}
        end
        
        should redirect_to("home") { root_path }
      end
      
      context "with invalid user credentials" do
        setup do    
          post :create, :user_session => { :login => "sampleUser", :password => "failure"}
        end
        
        should respond_with(:success)
        should render_template :new
      end
    end
    
    context "on DELETE to destroy" do
      setup do
        # Create a session
        UserSession.create @user
        
        delete :destroy
      end
      
      should_redirect_home
    end
    
    context "for a logged in user" do
      setup do
        UserSession.create @user
      end
      
      context "on GET to #new" do
        setup do
          get :new
        end
        
        should set_the_flash.to("You must be logged out to access this page")
        should redirect_to("home") { root_path }
      end
      
      context "on POST to #create" do
        setup do
          post :create, :user_session => { :login => "sampleUser", :password => "password"}
        end
        
        should set_the_flash.to("You must be logged out to access this page")
        should redirect_to("home") { root_path }
      end
      
    end
    
  end
  
end