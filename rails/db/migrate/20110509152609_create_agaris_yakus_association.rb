class CreateAgarisYakusAssociation < ActiveRecord::Migration
  def self.up
    create_table :agaris_yakus, :id => false do |t|
      t.integer :agari_id
      t.integer :yaku_id
    end
  end

  def self.down
    drop_table :agaris_yakus
  end
end
