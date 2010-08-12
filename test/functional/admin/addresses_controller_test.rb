require 'test_helper'

class Admin::AddressesControllerTest < ActionController::TestCase
  context "An Admin::AddressesController" do
    setup do
      login_user
      @address = Factory.create(:address)
    end
    
    
  end
end