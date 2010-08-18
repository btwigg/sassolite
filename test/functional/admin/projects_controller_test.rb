require 'test_helper'

class Admin::ProjectsControllerTest < ActionController::TestCase
  context "An Admin::ProjectsController" do
    setup do
      login_user
      
      @project = Factory.create(:project, :project_manager => @user)
      @project_duration = @project.project_durations.create(:start => Date.today- 1.week, :end => Date.today + 1.week)
      Factory.create(:project_number)
    end
    
    context "on GET to #index" do
      context "with a status update" do
        setup do
          @status_update = @project_duration.status_updates.create(:user => @user, :description => "lorem", :entry_date => Date.today)
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
      
        should "display name of project code" do
          assert_select "p", /Project Code: 1701/
        end
      
        should "display name of project manager" do
          assert_select "p", /Project Manager: Sample User/
        end
      
        should "display project type " do
          assert_select "p", /Project Type: Time &amp; Maintenance/
        end
      
        should "current duration" do
          assert_select "p", /Current Duration: #{(Date.today- 1.week).strftime("%m/%d/%Y")} - #{(Date.today + 1.week).strftime("%m/%d/%Y")}/
        end
      
        should "select a client" do
          assert_select "p", /Client: Quentin Corp/
        end
      
        should "display edit durations link" do
          assert_select "a", /Edit Durations/
        end
      
        should "display who created the last status update and when" do
          assert_select "p", /Status Last Updated By Sample User on #{Date.today.strftime("%m/%d/%Y")}./
        end
        
        should "display a link to update the project's status" do
          assert_select "a", /Update Status/
        end
        
      end
      
      context "with a locked status update" do
        setup do
          @status_update = @project_duration.status_updates.create(:user => @user, :description => "lorem", :entry_date => Date.today)
          @status_update.lock!
          get :index
        end
        
        should respond_with :success
        should "display a link to unlock the project's status" do
          assert_select "a", /Unlock Status/
        end
        
      end
      
      context "without a status update" do
        setup do
          get :index
        end
        
        should "display message the project has no status updates." do
          assert_select "p", /No Status Updates for this Project./
        end
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
      
      should assign_to(:project_managers)
      should assign_to(:project_types)
      should assign_to(:clients)
      
      should "select a client" do
        assert_select "label", /Client/
      end
      
      should "select a project manager" do
        assert_select "label", /Project Manager/
      end
      
      should "select a project type" do
        assert_select "label", /Project Type/
      end
    end
       
    context "on POST to #create" do
           
      context "with valid data" do
        setup do
          post :create, :project => { :name => "Seti Alpha 6 Exploration"}
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
        
        should assign_to(:project_managers)
        should assign_to(:project_types)
        should assign_to(:clients)
  
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
      
      should_display_a_headline "Editing 'Space Seeding'"
      
      should_display_a_form
      should_display_a_breadcrumb
      
      should assign_to(:project_managers)
      should assign_to(:project_types)
      should assign_to(:clients)
      
      should "select a client" do
        assert_select "label", /Client/
      end
      
      should "select a project manager" do
        assert_select "label", /Project Manager/
      end
      
      should "select a project type" do
        assert_select "label", /Project Type/
      end
    end
    
    context "on PUT to #update" do
      
      context "with valid data" do
        setup do
          put :update, :project => { :name => "Seti Alpha 6 Exploration"}, :id => @project
        end
        
        should redirect_to("admin projects index") { admin_projects_path }
        should assign_to :project
        should set_the_flash.to "Project 'Seti Alpha 6 Exploration' has been updated."
      end
      
      context "with invalid data" do
        setup do
          put :update, :project => { :name => ""}, :id => @project
        end
        
        should respond_with :unprocessable_entity
        should assign_to :project
        should render_template :edit
        should set_the_flash.to "Project could not be updated."
        
        should assign_to(:project_managers)
        should assign_to(:project_types)
        should assign_to(:clients)

        should_display_an_error_message
      end
      
    end
       
    context "on DELETE to #destroy" do
      setup do
        delete :destroy, :id => @project
      end
  
      should redirect_to("admin projects index") { admin_projects_path }
      should assign_to(:project)
      should set_the_flash.to "Project 'Space Seeding' has been deleted."
      
      should "set the project to retired" do
        assert_equal "retired", assigns(:project).state
      end
  
    end
  end
end