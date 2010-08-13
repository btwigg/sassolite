require 'test_helper'

class Admin::ProjectsControllerTest < ActionController::TestCase
  context "An Admin::ProjectsController" do
    setup do
      login_user
      @project = Factory.create(:project)
    end
    
    context "on GET to #index" do
      setup do
        get :index
      end
      
      should respond_with :success
      should assign_to :projects
      should render_template :index
      
      should_display_a_headline "Projects"
      
      should "display projects" do
        assert_select "div.project"
      end
      
      should "display link to new project" do
        assert_select "a", /New Project/
      end
      
    end
    
    context "on GET to #new" do
      setup do
        get :new
      end
      
      should respond_with :success
      should assign_to :project
      should render_template :new
      
      should_display_a_headline "New Project"
      
      should_display_a_form
      should_display_a_breadcrumb
    end
       
    context "on POST to #create" do
           
      context "with valid data" do
        setup do
          post :create, :project => { :name => "New Project X"}
        end
  
        should redirect_to("admin projects index") { admin_projects_path }
        should assign_to(:project)
      end

      context "with invalid data" do
        setup do
          post :create, :project => {}
        end
  
        should respond_with :unprocessable_entity
        should assign_to :project
        should render_template :new
  
        should_display_an_error_message
      end

    end

    context "on GET to #edit" do
      setup do
        get :edit, :id => @project
      end
  
      should respond_with :success
      should assign_to :project
      should render_template :edit
      
      should_display_a_headline "Editing 'Quentin Corp'"
      
      should_display_a_form
      should_display_a_breadcrumb
    end
    
    context "on PUT to #update" do
      
      context "with valid data" do
        setup do
          put :update, :project => { :name => "New Project"}, :id => @project
        end
        
        should redirect_to("admin projects index") { admin_projects_path }
        should assign_to :project
        should set_the_flash.to "Project 'New Project' has been updated."
      end
      
      context "with invalid data" do
        setup do
          put :update, :project => { :name => ""}, :id => @project
        end
        
        should respond_with :unprocessable_entity
        should assign_to :project
        should render_template :edit
        should set_the_flash.to "Project could not be updated."

        should_display_an_error_message
      end
      
    end
       
    context "on DELETE to #destroy" do
      setup do
        delete :destroy, :id => @project
      end
  
      should redirect_to("admin projects index") { admin_projects_path }
      should assign_to(:project)
      should set_the_flash.to "Project 'Quentin Corp' has been deleted."
  
    end
  end
end