require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  
  context "An Address" do
    setup do
      @address = Factory.create(:address)
    end
    
    should belong_to :client
    should belong_to :address_type
  end
  
end
