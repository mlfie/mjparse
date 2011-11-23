class AlterAgariManganScaleToFloat < ActiveRecord::Migration
  def self.up
    #change_column :agaris, :mangan_scale, :decimal, :precision => 2, :scale => 1
    change_column :agaris, :mangan_scale, :float
  end

  def self.down
    change_column :agaris, :mangan_scale, :integer
  end
end
