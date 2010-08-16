require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  
  context "The HomeController" do
    setup do
      login_user
    end
    
    context "on GET to index" do
      setup do
        get :index
      end
      
      should respond_with(:success)
      should render_template :index
      
      should_display_a_headline("Administration")
      
      should_display_a_link_to "Administer Users"
      should_display_a_link_to "Administer Clients"
      should_display_a_link_to "Administer Projects"
    end
    
  end

end
