class CreateFacturas < ActiveRecord::Migration
  def self.up
    create_table :facturas do |t|
      t.text :descr
      t.timestamps
    end
  end

  def self.down
    drop_table :facturas
  end
end
