class Admin::StatusUpdatesController < ApplicationController
  before_filter :load_relational_data
  
  protected
  
  def load_relational_data
    @client = Client.find(params[:client_id])
    @current_duration = @client.project_durations.current.first
  end  
  
end