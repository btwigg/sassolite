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
        
        should "display an error message" do
          assert_select "div.errorExplanation"
        end
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
