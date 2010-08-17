class Admin::ProjectDurationsController < ApplicationController
  before_filter :load_relational_data
  
  def index
    @project_durations = @project.project_durations
  end
  
  def new
    @project_duration = ProjectDuration.new
  end
  
  def create
    @project_duration = @project.project_durations.new(params[:project_duration])
  
    if @project_duration.save
      flash[:notice] = %{New duration for project "#{@project.name}" has been created.}
      redirect_to admin_project_project_durations_path(@project)
    else
      flash[:error] = "Project duration could not be created."
      render :new, :status => :unprocessable_entity
    end
  end
  
  def edit
    @project_duration = ProjectDuration.find(params[:id])
  end
  
  def update
    @project_duration = ProjectDuration.find(params[:id])
    
    if @project_duration.update_attributes(params[:project_duration])
      flash[:notice] = %{Project "#{@project.name}" #{@project_duration.name} has been updated.}
      redirect_to admin_project_project_durations_path(@project)
    else
      flash[:error] = "Project duration could not be updated."
      render :edit, :status => :unprocessable_entity
    end
  end
  
  def destroy
    @project_duration = ProjectDuration.find(params[:id])
    @project_duration.destroy
    flash[:notice] = %{Project "#{@project.name}" #{@project_duration.name} has been deleted.}
    redirect_to admin_project_project_durations_path
  end
  
  private
  
  def load_relational_data
    @project = Project.find(params[:project_id])
  end
  
end