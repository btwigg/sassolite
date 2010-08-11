class Admin::UsersController < ApplicationController

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.generate_random_password
        
    if @user.save
      flash[:notice] = "Created user '#{@user.login}'."
      redirect_to admin_users_path
    else
      logger.debug @user.errors
      flash[:error] = "Could not create user '#{@user.login}'."
      render :new
    end
  end

end