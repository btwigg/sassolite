class IndexTheExistingTables < ActiveRecord::Migration
  def self.up
    add_index :address_types, :name
    add_index :addresses, :address_type_id
    add_index :addresses, :client_id
    add_index :clients, :name
    add_index :project_types, :name
    add_index :projects, :name
    add_index :projects, :code
    add_index :projects, :project_type_id
    add_index :projects, :project_manager_id
    add_index :projects, :client_id
  end

  def self.down
    remove_index :address_types, :name
    remove_index :addresses, :address_type_id
    remove_index :addresses, :client_id
    remove_index :clients, :name
    remove_index :project_types, :name
    remove_index :projects, :name
    remove_index :projects, :code
    remove_index :projects, :project_type_id
    remove_index :projects, :project_manager_id
    remove_index :projects, :client_id
  end
end
