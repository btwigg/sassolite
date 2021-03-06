class Admin::UsersController < ApplicationController

  def index
    @users = User.enabled.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    password = @user.generate_random_password
        
    if @user.save
      UserMailer.password_reset(@user, password).deliver
      flash[:notice] = "Created user '#{@user.login}'."
      redirect_to admin_users_path
    else
      logger.debug @user.errors
      flash[:error] = "Could not create user '#{@user.login}'."
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    
    if User.enabled.count > 1
      @user.disable!
      flash[:notice] = "User '#{@user.login}' has been deleted."
    else
      flash[:error] = "User '#{@user.login}' cannot be deleted.  At least one user must exist in the system."
    end
    
    redirect_to admin_users_path
  end
end
