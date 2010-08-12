class Admin::AddressesController < ApplicationController
  before_filter :load_address_variables
  
  def new
    if @address
      flash[:error] = "An address with type '#{@address_type.name}' already exists for client '#{@client.name}'."
      redirect_to admin_clients_path
    else
      @address = Address.new(:client => @client, :address_type => @address_type)
    end
  end
  
  def create
    @address = Address.new(params[:address])
    @address.client = @client
    @address.address_type = @address_type
    
    if @address.save
      flash[:notice] = "Created address of type '#{@address_type.name}' for client '#{@client.name}'."
      redirect_to admin_clients_path
    else
      flash[:error] = "Cannot create address of type '#{@address_type.name}' for client '#{@client.name}'."
      render :new, :status => :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @address.update_attributes(params[:address])
      flash[:notice] = ""
      redirect_to admin_clients_path
    else
      flash[:error] = ""
      render :edit, :status => :unprocessable_entity
    end
  end
  
  protected
  
  def load_address_variables
    @client = Client.find(params[:client_id])
    @address_type = AddressType.find(params[:address_type_id])
    @address = Address.where(:client_id => @client, :address_type_id => @address_type).first
  end  
  
end