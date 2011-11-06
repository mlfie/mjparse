class AddStatusCodeToAgaris < ActiveRecord::Migration
  def self.up
    add_column :agaris, :status_code, :integer
  end

  def self.down
    remove_column :agaris, :status_code
  end
end
