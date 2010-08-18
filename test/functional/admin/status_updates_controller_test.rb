require 'test_helper'

class Admin::StatusUpdatesControllerTest < ActionController::TestCase
  
  def generate_status_update
    @status_update = @project_duration.status_updates.create(:user => @quentin, :entry_date => Date.today, :description => "lorem ipson dolar")
  end
  
  context "An Admin::StatusUpdatesController" do
    setup do      
      create_quentin_user # create quentin before logging in to avoid session issue
      login_user
      
      @project_duration = Factory.create(:project_duration)
      @project = @project_duration.project
    end
    
    context "on GET to #edit" do
      
      context "where a current duration exists" do
        
        context "where a status update exists" do
          setup do
            generate_status_update
            get :edit, :project_id => @project
          end

          should render_template :edit
          should assign_to(:project_duration)
          should assign_to(:status_update)
          should_display_a_form
          should_display_a_headline "Status Update for #{Date.today.to_s(:long)}"
          
          should "set the user to the current user" do
            assert_equal @user, assigns(:status_update).user
          end
          
          should "set the status of the update to locked" do
            assert assigns(:status_update).locked?
          end
        end

        context "where a status update doesn't exist" do
          setup do
            get :edit, :project_id => @project
          end
          
          should render_template :edit
          should assign_to(:project_duration)
          should assign_to(:status_update)
          should_display_a_form
          should_display_a_headline "Status Update for #{Date.today.to_s(:long)}"
          
          should "generate a new status update" do
            assert_equal false, assigns(:status_update).new_record?
          end

          should "generate a new status update with today's date" do
            assert_equal Date.today, assigns(:status_update).entry_date
          end
          
          should "generate a new status update generated by the logged in user" do
            assert_equal @user, assigns(:status_update).user
          end
        end
        
      end
      
      context "where a status update exists and is locked" do
        setup do
          generate_status_update
          @status_update.lock!
        end
        
        context "by a user other than the current user" do
          setup do
            get :edit, :project_id => @project
          end
        
          should set_the_flash.to "Cannot edit status for project 'Space Seeding'.  The update is locked by 'Quentin User'."
          should redirect_to("admin project path") { admin_projects_path }
        end
        
        context "by the current user" do
          setup do
            @status_update.user = @user
            @status_update.save
            get :edit, :project_id => @project
          end
          
          should render_template :edit
          should respond_with :success
        end
      end
      
      context "where a current duration doesn't exist" do
        setup do
          @project_duration.destroy
          get :edit, :project_id => @project
        end
        
        should set_the_flash.to("Cannot update project with a current duration.")
        should redirect_to("admin project index") { admin_projects_path }
      end
      
    end
    
    context "on PUT to #update" do
      setup do
        generate_status_update
        @status_update.user = @user
        @status_update.save
        @status_update.lock!
      end
      
      context "with valid data" do
        setup do
          put :update, :status_update => { :description => "New Status Info here."}, :project_id => @project
        end
        
        should set_the_flash.to "Updated status for Project 'Space Seeding'."
        should redirect_to("admin projects path") { admin_projects_path }
        
        should "set the status of the update to open" do
          assert assigns(:status_update).open?
        end
      end
      
      context "with invalid data" do
        setup do
          put :update, :status_update => { :description => "" }, :project_id => @project
        end
        
        should set_the_flash.to "Could not update status for Project 'Space Seeding'."
        should render_template :edit
        should respond_with :unprocessable_entity
        should_display_a_form
        should_display_an_error_message
      end
      
    end
    
    context "on POST to #unlock" do
      context "where a status update exists and is locked" do
        setup do
          generate_status_update
          @status_update.lock!
          post :unlock, :project_id => @project
        end

        should set_the_flash.to("Status update for project 'Space Seeding' has been unlocked.")
        should redirect_to("admin projects path") { edit_admin_project_status_update_path(@project) }
        should "unlock the status update" do
          assert assigns(:status_update).open?
        end

      end

      context "where a status update exists and is not locked" do
        setup do
          generate_status_update
          post :unlock, :project_id => @project
        end

        should set_the_flash.to("Status update for project 'Space Seeding' has been unlocked.")
        should redirect_to("admin projects path") { edit_admin_project_status_update_path(@project) }
        should "unlock the status update" do
          assert assigns(:status_update).open?
        end
      end
    end
    
  end
  
end