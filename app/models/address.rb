class Address < ActiveRecord::Base
  belongs_to :client
  belongs_to :address_type
  
  validates :email, :format => { :with => Regexp.new( "^[a-z0-9!\#\$\%\&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!\#\$\%\&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$") }
end
