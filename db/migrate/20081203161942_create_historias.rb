class CreateHistorias < ActiveRecord::Migration
  def self.up
    create_table :historias do |t|
      t.integer :cantidad
      t.text :talla
      t.text :marca
      t.text :estillo
      t.text :tipo
      t.text :genetico
      t.text :factura
      t.text :ubicacion     
      t.references :factura
      t.references :inventario
      
      t.timestamps
    end
  end

  def self.down
    drop_table :historias
  end
end
