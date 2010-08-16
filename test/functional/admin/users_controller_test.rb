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
      
      should_display_a_headline "Users"
      
      should "display a table of users" do
        assert_select "table"
      end
      
      should "display a table header for Login" do
        assert_select "th", /Login/
      end
      
      should "display a table header for Name" do
        assert_select "th", /Name/
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
      
      should_display_a_headline "New User"
      
      should_display_a_form
      should_display_a_breadcrumb
    end
    
    context "on POST to #create" do
      
      context "with valid data" do
        setup do
          post :create, :user => { :login => "newuser", :initials => "NU", :name => "New User", :email => "new.user@example.com"}
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
        
        should_display_an_error_message
      end
      
    end
    
    context "on DELETE to #destroy" do
      context "with one user" do
        setup do
          # create a second user
          @alternate_user = Factory.create(
            :user, 
            :login => "alternateUser", 
            :name => "Alternate User", 
            :email => "alternate.user@example.com", 
            :initials => "AU",
            :password => "fakePassword",
            :password_confirmation => "fakePassword"
          )

          delete :destroy, :id => @alternate_user
        end
        
        should redirect_to("admin users index") { admin_users_path }
        should assign_to(:user)
        should set_the_flash.to "User 'alternateUser' has been deleted."
        
        should "set the user state to disabled" do
          assert_equal "disabled", assigns(:user).state
        end
      end

      context "with more than one user" do
        setup do
          delete :destroy, :id => @user
        end
        
        should redirect_to("admin users index") { admin_users_path }
        should assign_to(:user)
        should set_the_flash.to "User 'sampleUser' cannot be deleted.  At least one user must exist in the system."
        
        should "have 1 user left in the system" do
          assert_equal 1, User.count
        end
      end

    end
  end
end
