class CreateYakus < ActiveRecord::Migration
  def self.up
    create_table :yakus do |t|
      t.string :name_kanji
      t.string :name_kana
      t.integer :han_num
      t.integer :naki_han_num

      t.timestamps
    end
  end

  def self.down
    drop_table :yakus
  end
end
