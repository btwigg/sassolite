require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  
  context "The HomeController" do
    setup do
      login_user
      @project_duration = Factory.create(:project_duration)
      @project = @project_duration.project
      @project.project_manager = @user
      @project.save
    end
    
    context "on GET to index" do
      setup do
        get :index
      end
      
      should respond_with(:success)
      should render_template :index
      
      should assign_to(:projects)
      
      should_display_a_headline("My Current Projects")
      should "have a project div" do
        assert_select "div.project", 1
      end
      
      should_display_a_headline("Report")
      should_display_a_link_to "Current Report"
            
      should_display_a_headline("Administration")
      should_display_a_link_to "Administer Users"
      should_display_a_link_to "Administer Clients"
      should_display_a_link_to "Administer Projects"
    end
    
  end

end
