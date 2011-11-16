class DestroyImages < ActiveRecord::Migration
  def self.up
    drop_table :images
  end

  def self.down
    create_table :images do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.string :image_remote_url

      t.timestamps
    end
  end
end
