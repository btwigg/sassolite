require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  
  context "The ReportsController" do
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
      should assign_to(:date)
      
      should "display a report table" do
        assert_select "table#report", 1
      end
      
      should "display a table header" do
        assert_select "table#report thead", 1
      end
      
      should "display a table body" do
        assert_select "table#report tbody", 1
      end
      
      should "display report detail" do
        assert_select "table#report tbody tr.report-details", 1
      end
      
      should "display report update" do
        assert_select "table#report tbody tr.report-update", 1
      end
      
      should_display_a_headline("Report for #{Date.today.to_s(:long)}")
      
      
    end
    
  end

end
