class Client < ActiveRecord::Base
  has_many :projects
  has_many :addresses
  
  validates :name, :presence => true, :uniqueness => true
end
