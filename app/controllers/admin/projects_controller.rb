class Admin::ProjectsController < ApplicationController
  before_filter :load_relational_data, :except => [:index, :destroy]
  
  def index
    @projects = Project.paginate(:page => params[:page], :per_page => 5)
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    @project.code = ProjectNumber.next_code!
    
    if @project.save
      flash[:notice] = "Project '#{@project.name}' has been created."
      redirect_to admin_projects_path
    else
      flash[:error] = "Project could not be created."
      render :new, :status => :unprocessable_entity
    end
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project '#{@project.name}' has been updated."
      redirect_to admin_projects_path
    else
      flash[:error] = "Project could not be updated."
      render :edit, :status => :unprocessable_entity
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Project '#{@project.name}' has been deleted."
    redirect_to admin_projects_path
  end
  
  protected
  
  def load_relational_data
    @project_managers = User.all
    @project_types = ProjectType.all
  end
  
end
