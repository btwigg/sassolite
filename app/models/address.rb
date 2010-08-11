class Address < ActiveRecord::Base
  belongs_to :client
  belongs_to :address_type
  
  validates :email, :presence => true, :email_format => true #, :format => { :with => Regexp.new( "^[a-z0-9!\#\$\%\&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!\#\$\%\&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$") }
  validates :name, :presence => true
  validates :address1, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :phone, :presence => true
end
