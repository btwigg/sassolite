class CreateProjectDurations < ActiveRecord::Migration
  def self.up
    create_table :project_durations do |t|
      t.date :start
      t.date :end
      t.float :hours_allocated, :default => 0
      t.float :hours_elapsed, :default => 0
      t.text :notes
      t.integer :project_id

      t.timestamps
    end
    
    add_index :project_durations, :project_id
  end

  def self.down
    drop_table :project_durations
  end
end
