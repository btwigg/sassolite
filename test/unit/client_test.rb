require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  
  context "A Client" do
    setup do
      @client = Factory.create(:client)
    end
    
    should have_many :projects
    
    should validate_presence_of :name
    should validate_uniqueness_of :name
  end
  
end
