class AddIsFuroToAgaris < ActiveRecord::Migration
  def self.up
    add_column :agaris, :is_furo, :boolean
  end

  def self.down
    remove_column :agaris, :is_furo
  end
end
