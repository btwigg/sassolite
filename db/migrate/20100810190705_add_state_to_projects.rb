class AddStateToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :state, :string
    add_index :projects, :state
  end

  def self.down
    remove_column :projects, :state
  end
end
