class CreateSnapshots < ActiveRecord::Migration
  def self.up
    create_table :snapshots do |t|
      t.string :title
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :snapshots
  end
end
