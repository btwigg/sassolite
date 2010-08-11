class CreateStatusUpdates < ActiveRecord::Migration
  def self.up
    create_table :status_updates do |t|
      t.text :description
      t.date :entry_date, :default => Date.today
      t.integer :user_id
      t.integer :project_duration_id
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :status_updates
  end
end
