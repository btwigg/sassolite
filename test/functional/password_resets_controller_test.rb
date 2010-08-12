require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  
  context "A PasswordResetsController" do
    setup do
      create_user
    end
    
    context "on GET to #new" do
      setup do
        get :new
      end
      
      should respond_with :success
      should render_template :new
      
      should "display Password Reset headline" do
        assert_select "h2", /Password Reset/
      end
      
      should "display a form" do
        assert_select "form"
      end
    end
    
    context "on POST to #create" do
            
      context "with a login" do
        setup do
          post :create, :user => { :login => @user.login }
        end
        
        should assign_to(:user)
        should redirect_to("home") { root_path}
        should set_the_flash.to("If your identifer is found, you will recieve an email with a new password.")
      end
      
      context "with an email address" do
        setup do
          post :create, :user => { :login => @user.email }
        end
        
        should assign_to(:user)
        should redirect_to("home") { root_path}
        should set_the_flash.to("If your identifer is found, you will recieve an email with a new password.")
      end
      
      context "with an invalid identifier" do
        setup do
          post :create, :user => { :login => "derp" }
        end
        
        should respond_with :unprocessable_entity
        should render_template :new
        should set_the_flash.to("We could not find your account.  Please try again.")
      end
      
    end
    
  end

end
