class CreateProjectNumbers < ActiveRecord::Migration
  def self.up
    create_table :project_numbers do |t|
      t.integer :code

      t.timestamps
    end
  end

  def self.down
    drop_table :project_numbers
  end
end
