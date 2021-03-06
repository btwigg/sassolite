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
      
      should_display_a_headline "Clients"
      
      should "display clients" do
        assert_select "div.client"
      end
      
      should "display link to new client" do
        assert_select "a", /New Client/
      end
      
      should "display a link to a new mailing address" do
        assert_select "a", /New Mailing Address/
      end
      
      should "display a link to a new billing address" do
        assert_select "a", /New Billing Address/
      end
    end
    
    context "with existing addresses" do
      setup do
        # Create a mailing address
        address = @client.addresses.new
        address.address_type = Factory.create(:address_type)
        address.save(false)
        
        # Create a billing address
        address = @client.addresses.new
        address.address_type = Factory.create(:address_type, :name => "Billing")
        address.save(false)
        
        get :index
      end
      
      should "display a link to edit the mailing address" do
        assert_select "a", /Edit Mailing Address/
      end
      
      should "display a link to edit the billing address" do
        assert_select "a", /Edit Billing Address/
      end
    end
    
    context "on GET to #new" do
      setup do
        get :new
      end
      
      should respond_with :success
      should assign_to :client
      should render_template :new
      
      should_display_a_headline "New Client"
      
      should_display_a_form
      should_display_a_breadcrumb
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
  
        should_display_an_error_message
      end

    end

    context "on GET to #edit" do
      setup do
        get :edit, :id => @client
      end
  
      should respond_with :success
      should assign_to :client
      should render_template :edit
      
      should_display_a_headline "Editing 'Quentin Corp'"
      
      should_display_a_form
      should_display_a_breadcrumb
    end
    
    context "on PUT to #update" do
      
      context "with valid data" do
        setup do
          put :update, :client => { :name => "New Client"}, :id => @client
        end
        
        should redirect_to("admin clients index") { admin_clients_path }
        should assign_to :client
        should set_the_flash.to "Client 'New Client' has been updated."
      end
      
      context "with invalid data" do
        setup do
          put :update, :client => { :name => ""}, :id => @client
        end
        
        should respond_with :unprocessable_entity
        should assign_to :client
        should render_template :edit
        should set_the_flash.to "Client could not be updated."

        should_display_an_error_message
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