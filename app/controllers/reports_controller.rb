class ReportsController < ApplicationController
  
  def index
    @date = Date.today
    @projects = Project.open
  end
  
end