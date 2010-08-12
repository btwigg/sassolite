class Admin::ClientsController < ApplicationController
  
  def index
    @clients = Client.paginate(:page => params[:page], :per_page => 5)
  end
  
  def new
    @client = Client.new
  end
  
  def create
    @client = Client.new(params[:client])
    
    if @client.save
      flash[:notice] = "Client '#{@client.name}' has been created."
      redirect_to admin_clients_path
    else
      flash[:error] = "Client could not be created."
      render :new, :status => :unprocessable_entity
    end
  end
  
  def edit
    @client = Client.find(params[:id])
  end
  
  def update
    @client = Client.find(params[:id])
    
    if @client.update_attributes(params[:client])
      flash[:notice] = "Client '#{@client.name}' has been updated."
      redirect_to admin_clients_path
    else
      flash[:error] = "Client could not be updated."
      render :edit, :status => :unprocessable_entity
    end
  end
  
  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    flash[:notice] = "Client '#{@client.name}' has been deleted."
    redirect_to admin_clients_path
  end
  
end
