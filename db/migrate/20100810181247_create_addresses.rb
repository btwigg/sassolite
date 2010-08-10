class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :phone
      t.string :fax
      t.string :url
      t.string :email
      t.integer :address_type_id
      t.string :city
      t.string :state
      t.string :zipcode
      t.integer :client_id

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
