class AddPhotoAttachmentToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :photo_file_name, :string
    add_column :items, :photo_content_type, :string
    add_column :items, :photo_file_size, :integer
    add_column :items, :photo_updated_at, :datetime
  end

  def self.down
    remove_column :items, :photo_file_name, :string
    remove_column :items, :photo_content_type, :string
    remove_column :items, :photo_file_size, :integer
    remove_column :items, :photo_updated_at, :datetime
  end
end
