class ReportsController < ApplicationController
  
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @projects = Project.open_on(@date)
  end
  
end