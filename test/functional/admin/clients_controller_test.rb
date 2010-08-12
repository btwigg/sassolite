require 'test_helper'

class Admin::ClientsControllerTest < ActionController::TestCase
  context "An Admin::ClientsController" do
    setup do
      login_user
      @client = Factory.create(:client)
    end
    
    context "on GET to #index" do
      setup do
        get :index, :id => @client.name
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
          post :create, :client => { :name => "New Client X"}
        end
  
        should redirect_to("admin clients index") { admin_clients_path }
        should assign_to(:client)
      end

      context "with invalid data" do
        setup do
          post :create, :client => {}
        end
  
        should respond_with :unprocessable_entity
        should assign_to :client
        should render_template :new
  
        should "display an error message" do
          assert_select "div.errorExplanation"
        end
      end

    end

    context "on GET to #edit" do
      setup do
        get :edit, :id => @client
      end
  
      should respond_with :success
      should assign_to :client
      should render_template :edit
  
      should "display Editing 'Client Name' headline" do
        assert_select "h2", /Editing '#{@client.name}'/
      end
  
      should "display a form" do
        assert_select "form"
      end
    end
    
    context "on PUT to #update" do
      
      context "with valid data" do
        setup do
          put :update, :client => { :name => "New Client"}, :id => @client
        end
        
        should redirect_to("admin clients index") { admin_clients_path }
        should assign_to :client
        should set_the_flash.to "Client 'Quentin Corp' has been updated."
      end
      
      context "with invalid data" do
        setup do
          put :update, :client => { :name => ""}
        end
        
        should respond_with :unprocessable_entity
        should assign_to :client
        should render_template :edit
        should set_the_flash.to "Client could not be updated."

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
      should set_the_flash.to "Client 'Quentin Corp' has been deleted."
  
    end
  end
end