class Address < ActiveRecord::Base
  belongs_to :client
  belongs_to :address_type
end
