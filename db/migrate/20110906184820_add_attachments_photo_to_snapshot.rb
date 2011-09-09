class AddAttachmentsPhotoToSnapshot < ActiveRecord::Migration
  def self.up
    add_column :snapshots, :photo_file_name, :string
    add_column :snapshots, :photo_content_type, :string
    add_column :snapshots, :photo_file_size, :integer
    add_column :snapshots, :photo_updated_at, :datetime
  end

  def self.down
    remove_column :snapshots, :photo_file_name, :string
    remove_column :snapshots, :photo_content_type, :string
    remove_column :snapshots, :photo_file_size, :integer
    remove_column :snapshots, :photo_updated_at, :datetime
  end
end
