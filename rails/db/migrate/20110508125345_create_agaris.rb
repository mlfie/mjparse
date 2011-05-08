class CreateAgaris < ActiveRecord::Migration
  def self.up
    create_table :agaris do |t|
      t.boolean :is_ippatsu, :default => false
      t.boolean :is_parent, :default => false
      t.boolean :is_tsumo, :default => false
      t.integer :dora_num, :default => 0
      t.string :bakaze, :default => 'none'
      t.string :jikaze, :default => 'none'
      t.integer :honba_num, :default => 0
      t.integer :reach_num, :default => 0
      t.boolean :is_haitei, :default => false
      t.boolean :is_rinshan, :default => false
      t.boolean :is_chankan, :default => false
      t.boolean :is_tenho, :default => false
      t.boolean :is_chiho, :default => false
      t.integer :total_fu_num
      t.integer :total_han_num
      t.integer :mangan_scale
      t.integer :total_point
      t.integer :parent_point
      t.integer :child_point
      t.text :tehai_img
      t.string :tehai_list

      t.timestamps
    end
  end

  def self.down
    drop_table :agaris
  end
end
