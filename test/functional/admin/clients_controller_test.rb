require 'test_helper'

class Admin::ClientsControllerTest < ActionController::TestCase
  context "An Admin::ClientsController" do
    setup do
      login_user
      @client = Factory.create(:client)
    end
    
    context "on GET to #index" do
      setup do
        get :index
      end
      
      should respond_with :success
      should assign_to :clients
      should render_template :index
      
      should "display Clients headline" do
        assert_select "h2", /Clients/
      end
      
      should "display clients" do
        assert_select "div.client"
      end
      
    end
    
    context "on GET to #new" do
      setup do
        get :new
      end
      
      should respond_with :success
      should assign_to :client
      should render_template :new
      
      should "display New Client headline" do
        assert_select "h2", /New Client/
      end
      
      should "display a form" do
        assert_select "form"
      end
    end
    
    context "on POST to #create" do
      
      context "with valid data" do
        setup do
          post :create
        end
        
        should redirect_to("admin clients index") { admin_clients_path }
        should assign_to(:client)
        
      end
      
      context "with invalid data" do
        setup do
          post :create
        end
        
        should respond_with :success
        should assign_to :client
        should render_template :new
        
        should "display an error message" do
          assert_select "div.errorExplanation"
        end
      end
      
    end
    
    context "on DELETE to #destroy" do
      setup do
        delete :destroy, :id => @client
      end
      
      should redirect_to("admin clients index") { admin_clients_path }
      should assign_to(:client)
      should set_the_flash.to "Client 'Quentin Corp' has been deleted"
      
    end
  end
end
