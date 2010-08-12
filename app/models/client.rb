class Client < ActiveRecord::Base
  has_many :projects
  has_many :addresses
  
  has_one :billing_address, :class_name => "Address", :conditions => "address_type_id = (SELECT id FROM address_types WHERE name ='Billing')"
  has_one :mailing_address, :class_name => "Address", :conditions => "address_type_id = (SELECT id FROM address_types WHERE name ='Mailing')"
  
  validates :name, :presence => true, :uniqueness => true
end
