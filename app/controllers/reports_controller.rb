class ReportsController < ApplicationController
  
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @projects = Project.joins(:project_durations).where(["project_durations.start <= ? AND project_durations.end >= ?", @date, @date])
  end
  
end