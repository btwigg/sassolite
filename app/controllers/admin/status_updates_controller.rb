class Admin::StatusUpdatesController < ApplicationController
  before_filter :load_relational_data
  before_filter :verify_lock
  
  def edit
    @status_update.user = current_user
    @status_update.lock!
  end
  
  def update
    @status_update.reopen!
    if @status_update.update_attributes(params[:status_update])
      flash[:notice] = "Updated status for Project '#{@project.name}'."
      redirect_to admin_projects_path
    else
      flash[:error] = "Could not update status for Project '#{@project.name}'."
      render :edit, :status => :unprocessable_entity
    end
  end
  
  protected
  
  def verify_lock
    if @status_update.locked? && current_user != @status_update.user
      flash[:error] = "Cannot edit status for project '#{@project.name}'.  The update is locked by '#{@status_update.user.name}'."
      redirect_to admin_projects_path
    end
  end
  
  def load_relational_data
    @project = Project.find(params[:project_id])
    @project_duration = @project.project_durations.current.first
    
    # If there is no project duration, do not continue
    if @project_duration.nil?
      flash[:error] = "Cannot update project with a current duration."
      redirect_to admin_projects_path
    else
      # Find the current status update
      @status_update = @project_duration.status_updates.where(:entry_date => Date.today).first
      
      # If it doesn't exist, create it
      if @status_update.nil?
        @status_update = @project_duration.status_updates.create(:entry_date => Date.today, :user => current_user, :description => "New Entry.")
      end
    end
  end  
  
end