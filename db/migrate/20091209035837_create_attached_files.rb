class CreateAttachedFiles < ActiveRecord::Migration
  def self.up
    create_table :attached_files do |t|
      t.integer :service_id, :null => false
      t.string :caption
      t.string :file_file_name
      t.string :file_content_type
      t.integer :file_file_size
      t.datetime :file_updated_at
    end

  end

  def self.down
    drop_table :attached_files
  end
end