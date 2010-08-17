require 'test_helper'

class Admin::ProjectDurationsControllerTest < ActionController::TestCase
  context "An Admin::ProjectDurationsController" do
    setup do
      login_user
      @project_duration = Factory.create(:project_duration)
      @project = @project_duration.project
    end
    
    context "on GET to #index" do
      setup do
        get :index, :project_id => @project.id
      end
      
      should respond_with :success
      should assign_to :project
      should render_template :index
      
      should_display_a_headline "Space Seeding Durations"
      
      should "display durations" do
        assert_select "div.project_duration"
      end
      
      should "display link to new duration" do
        assert_select "a", /New Duration/
      end
    end
    
    context "on GET to #new" do
      setup do
        get :new, :project_id => @project.id
      end
      
      should respond_with :success
      should assign_to :project
      should render_template :new
      
      should_display_a_headline "New Duration"
      
      should_display_a_form
      should_display_a_breadcrumb
      
      should "select a start" do
        assert_select "label", /Start/
      end
      
      should "select an end" do
        assert_select "label", /End/
      end
      
      should "select notes" do
        assert_select "label", /Notes/
      end
      
      should "select allocated hours" do
        assert_select "label", /Hours allocated/
      end
      
      should "select elapsed hours" do
        assert_select "label", /Hours elapsed/
      end
    end
    
    context "on POST to #create" do
      setup do
        @project_duration.destroy
      end
      
      context "with valid data" do
        setup do
          post :create, :project_id => @project, :project_duration => Factory.attributes_for(:project_duration)
        end
        
        should redirect_to("admin project durations index") { admin_project_project_durations_path(@project) }
        should assign_to :project
      end
      
      context "with invalid data, end before start" do
        setup do
          post :create, :project_id => @project, :project_duration => { :start => Date.today, :end => Date.today - 2.weeks }
        end
        
        should respond_with :unprocessable_entity
        should assign_to :project
        should render_template :new
        
        should_display_an_error_message
      end
      
      context "with invalid data, missing fields" do
        setup do
          post :create, :project_id => @project, :project_duration => {}
        end
        
        should respond_with :unprocessable_entity
        should assign_to :project
        should render_template :new
        
        should_display_an_error_message
      end
    end
    
    context "on GET to #edit" do
      setup do
        get :edit, :project_id => @project, :id => @project_duration
      end
      
      should respond_with :success
      should assign_to :project
      should render_template :edit
      
      should_display_a_headline 'Edit #{@project_duration.name}'
      
      should_display_a_form
      should_display_a_breadcrumb
      
      should "select a start" do
        assert_select "label", /Start/
      end
      
      should "select an end" do
        assert_select "label", /End/
      end
      
      should "select notes" do
        assert_select "label", /Notes/
      end
      
      should "select allocated hours" do
        assert_select "label", /Hours allocated/
      end
      
      should "select elapsed hours" do
        assert_select "label", /Hours elapsed/
      end
    end
    
    context "on PUT to #update" do
      
      context "with valid data" do
        setup do
          put :update, :project_id => @project, :id => @project_duration, :project_duration => {
            :notes => "Lorem ipsum dolor sit amet.",
            :hours_allocated => 500,
            :hours_elapsed => 50
          }
        end
        
        should redirect_to("admin project durations index") { admin_project_project_durations_path(@project) }
        should assign_to :project
      end
      
      context "with invalid data" do
        
      end
      
    end
    
    context "on DELETE to #destroy" do
      setup do
        delete :destroy, :project_id => @project, :id => @project_duration
      end
      
      should redirect_to("admin project durations index") { admin_project_project_durations_path(@project) }
      should assign_to :project
    end
    
  end
end