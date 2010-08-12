require 'test_helper'

class Admin::AddressesControllerTest < ActionController::TestCase
  context "An Admin::AddressesController" do
    setup do
      login_user      
    end
    
    context "for a new address" do
      setup do
        @client = Factory.create(:client)
        @address_type = Factory.create(:address_type)
      end
      
      context "on GET to #new" do
        setup do
          get :new, :client_id => @client, :address_type_id => @address_type
        end
        
        should assign_to(:client)
        should assign_to(:address_type)
        should assign_to(:address)
        
        should_display_a_form
        should_display_a_breadcrumb
        
        should "display the address type" do
          assert_select "p", /Mailing/
        end
      end
      
      context "on POST to #create" do
        
        context "with valid data" do
          setup do
            post :create, :address => Factory.attributes_for(:address), :client_id => @client, :address_type_id => @address_type
          end
          
          should assign_to(:client)
          should assign_to(:address_type)
          should assign_to(:address)
          should set_the_flash.to("Created address of type 'Mailing' for client 'Quentin Corp'.")
          should redirect_to("admin clients path") { admin_clients_path}
        end
        
        context "with invalid data" do
          setup do
            post :create, :address => {}, :client_id => @client, :address_type_id => @address_type
          end
          
          should assign_to(:client)
          should assign_to(:address_type)
          should assign_to(:address)
          should respond_with :unprocessable_entity
          should set_the_flash.to("Cannot create address of type 'Mailing' for client 'Quentin Corp'.")
        end
        
      end
      
    end
    
    context "for an existing address" do
      setup do
        @address = Factory.create(:address)
        @address_type = @address.address_type
        @client = @address.client
      end
      
      context "on GET to #new" do
        setup do
          get :new, :client_id => @client, :address_type_id => @address_type, :id => @address
        end
        
        should redirect_to("admin clients path") { admin_clients_path}
        should set_the_flash.to("An address with type 'Mailing' already exists for client 'Quentin Corp'.")
      end
      
      context "on GET to #edit" do
        setup do
          get :edit, :client_id => @client, :address_type_id => @address_type, :id => @address
        end
        
        should assign_to(:client)
        should assign_to(:address_type)
        should assign_to(:address)
        
        should_display_a_form
        should_display_a_breadcrumb
        
        should "display the address type" do
          assert_select "p", /Mailing/
        end
      end
      
      context "on PUT to #update" do
        
        context "with valid data" do
          setup do
            post :update, :client_id => @client, :address_type_id => @address_type, :id => @address
          end
        end
        
        context "with invalid data" do
          setup do
            post :update, :client_id => @client, :address_type_id => @address_type, :id => @address
          end
        end
        
      end
    end
    
    
  end
end