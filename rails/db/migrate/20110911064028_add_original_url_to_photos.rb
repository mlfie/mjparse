class AddOriginalUrlToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :orig_url, :string
  end

  def self.down
    remove_column :photos, :orig_url
  end
end
