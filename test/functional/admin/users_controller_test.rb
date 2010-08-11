require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  context "An Admin::UsersController" do
    setup do
      login_user
    end
    
    context "on GET to #index" do
      setup do
        get :index
      end
      
      should respond_with :success
      should assign_to :users
      should render_template :index
      
      should "display Users headline" do
        assert_select "h2", /Users/
      end
      
      should "display a table of users" do
        assert_select "table"
      end
      
      should "display a table header for User" do
        assert_select "th", /User/
      end
      
      should "display a table header for Actions" do
        assert_select "th", /Actions/
      end
    end
    
    context "on GET to #new" do
      setup do
        get :new
      end
      
      should respond_with :success
      should assign_to :user
      should render_template :new
      
      should "display New User headline" do
        assert_select "h2", /New User/
      end
      
      should "display a form" do
        assert_select "form"
      end
    end
    
    context "on POST to #create" do
      
      context "with valid data" do
        setup do
          post :create, :user => { :login => "newuser"}
        end
        
        should redirect_to("admin users index") { admin_users_path }
        should assign_to(:user)
        
        should "set a crypted password" do
          assert assigns(:user).crypted_password
        end
        
      end
      
      context "with invalid data" do
        setup do
          post :create, :user => { :login => '#failuser#'}
        end
        
        should respond_with :success
        should assign_to :user
        should render_template :new
        
        should "display an error message" do
          assert_select "div.errorExplanation"
        end
      end
      
    end
    
  end
end
