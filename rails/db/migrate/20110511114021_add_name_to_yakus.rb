class AddNameToYakus < ActiveRecord::Migration
  def self.up
    add_column :yakus, :name, :string
  end

  def self.down
    remove_column :yakus, :name
  end
end
