class AddThumUrlToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :thum_url, :string
  end

  def self.down
    remove_column :photos, :thum_url
  end
end
