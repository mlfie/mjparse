class AddImgUrlToAgaris < ActiveRecord::Migration
  def self.up
    add_column :agaris, :img_url, :string
  end

  def self.down
    remove_column :agaris, :img_url
  end
end
