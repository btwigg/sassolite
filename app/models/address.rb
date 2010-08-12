class Address < ActiveRecord::Base
  belongs_to :client
  belongs_to :address_type
  
  validates :email, :presence => true, :email_format => true
  validates :address_type_id, :uniqueness => { :scope => :client_id }
  validates :name, :presence => true
  validates :address1, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :phone, :presence => true
end
