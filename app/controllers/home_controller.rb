class HomeController < ApplicationController
  
  def index
    @projects = current_user.managed_projects.open_on(Date.today)
  end

end
