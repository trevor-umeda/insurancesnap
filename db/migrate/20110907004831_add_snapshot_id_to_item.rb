class AddSnapshotIdToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :snapshot_id, :integer
  end

  def self.down
    remove_column :items, :snapshot_id, :integer
  end
end
