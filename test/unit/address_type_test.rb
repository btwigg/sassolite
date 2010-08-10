require 'test_helper'

class AddressTypeTest < ActiveSupport::TestCase
  
  context "An AddressType" do
    setup do
      @address_type = Factory.create(:address_type)
    end
    
    should have_many :addresses
    
    should validate_presence_of :name
    should validate_uniqueness_of :name
  end
  
end
