class UserSessionsController < ApplicationController
  include ApplicationHelper
  
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save      
      # After the session is saved, we can retrieve the user record
      user = @user_session.record
      
      if user.enabled?
        flash[:notice] = "Login successful!"
        redirect_back_or_default root_path
      else
        @user_session.destroy
        flash[:error] = "Your account is disabled.  We cannot log you in."
        render :action => :new, :status => :unprocessable_entity
      end
    else
      flash[:error] = "Login failed.  Please try again."
      render :action => :new, :status => :unprocessable_entity
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_user_session_path
  end
end