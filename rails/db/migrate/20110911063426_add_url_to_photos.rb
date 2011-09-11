class AddUrlToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :url, :string
  end

  def self.down
    remove_column :photos, :url
  end
end
