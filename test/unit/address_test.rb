require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  
  context "An Address" do
    setup do
      @address = Factory.create(:address)
    end
    
    should belong_to :client
    should belong_to :address_type
    
    should validate_presence_of :name
    should validate_presence_of :address1
    should validate_presence_of :city
    should validate_presence_of :state
    should validate_presence_of :phone
    should validate_presence_of :email
    
    context "with an email" do 
      context "that is valid" do
        setup do
          @address.email = "test.user@example.org"
          @address.valid?
        end
        
        should "have no errors on email" do
          assert ! @address.errors.has_key?(:email)
        end
      end
      
      context "that is invalid" do
        setup do
          @address.email = "test.user@example##"
          @address.valid?
        end
        
        should "have errors on email" do
          assert @address.errors.has_key?(:email)
        end
      end
    end
    
    
  end
  
end
