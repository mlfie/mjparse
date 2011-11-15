class AddRonPointToAgaris < ActiveRecord::Migration
  def self.up
    add_column :agaris, :ron_point, :integer
  end

  def self.down
    remove_column :agaris, :ron_point
  end
end
