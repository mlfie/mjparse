class CreateAgariPais < ActiveRecord::Migration
  def self.up
    create_table :agari_pais do |t|
      t.string :type
      t.integer :number
      t.boolean :naki
      t.string :direction
      t.boolean :agari
      t.integer :index
      t.references :agari

      t.timestamps
    end
  end

  def self.down
    drop_table :agari_pais
  end
end
