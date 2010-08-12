require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  
  context "A PasswordResetsController" do
    setup do
      create_user
    end
    
    context "on GET to #new" do
      
      context "with a login" do
        setup do
          get :new, :id => @user.login
        end
        
        should respond_with :success
        should render_template :new
        should assign_to(:user)
        
        should "display Password Reset headline" do
          assert_select "h2", /Password Reset/
        end
        
        should "display a form" do
          assert_select "form"
        end
      end
      
      context "with an email address" do
        setup do
          get :new, :id => @user.email
        end
        
        should respond_with :success
        should render_template :new
        should assign_to(:user)
        
        should "display Password Reset headline" do
          assert_select "h2", /Password Reset/
        end
        
        should "display a form" do
          assert_select "form"
        end  
        
      end
      
    end
    
  end

end
