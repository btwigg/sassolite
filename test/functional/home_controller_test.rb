require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  
  context "The HomeController" do
    
    context "on GET to index" do
      setup do
        get :index
      end
      
      should respond_with(:success)
      should render_template :index
    end
    
  end

end
