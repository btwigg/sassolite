require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  
  context "The ReportsController" do
    setup do
      login_user
      @status_update = Factory.create(:status_update, :user => @user)
      @project_duration = @status_update.project_duration
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
      
      should "display report update" do
        assert_select "table#report tbody tr.report-update", 1
      end
      
      should "display a status update" do
        assert_select "td", /Lorem ipsom dolar/
      end
      
      should "display a calendar form" do
        assert_select "form input.datefield"
      end
      
      should_display_a_headline("Report for #{Date.today.to_s(:long)}")      
    end
    
    context "on GET to #index without a status update" do
      setup do
        @status_update.destroy
        get :index
      end
      
      should "display a default status update" do
        assert_select "td", /Status update unavailable./
      end
    end
    
    context "on GET to #index with a future date" do
      setup do
        @future_date = Date.parse("2012-12-21")
        get :index, :date => @future_date.to_s(:db)
      end
      
      should_display_a_headline "Report for December 21, 2012"
      
      should "assign date to future date" do
        assert_equal @future_date, assigns(:date)
      end
    end
    
    context "on GET to #index with a past date where no durations or updates exist" do
      setup do
        @past_date = Date.parse("1919-12-21")
        get :index, :date => @past_date.to_s(:db)
      end
      
      should "not find any projects" do
        assert_equal [], assigns(:projects)
      end
    end
    
  end

end
