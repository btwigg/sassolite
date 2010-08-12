class PasswordResetsController < ApplicationController
  skip_before_filter :require_user
  
  def new
  end
  
  def create
    @user = User.where(["login = :login OR email = :login", { :login => params[:user][:login]}]).first
    
    if @user      
      password = @user.generate_random_password
      UserMailer.password_reset(@user, password).deliver
      
      flash[:notice] = "If your identifer is found, you will recieve an email with a new password."
      redirect_to root_path
    else
      flash[:error] = "We could not find your account.  Please try again."
      render :new, :status => :unprocessable_entity
    end
  end
  
end
