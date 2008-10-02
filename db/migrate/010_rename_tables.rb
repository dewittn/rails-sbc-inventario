class RenameTables < ActiveRecord::Migration
  def self.up
    rename_table :inventario, :inventarios
    rename_table :color, :colors
    rename_table :talla, :tallas
    rename_table :marca, :marcas
    rename_table :tipo, :tipos  
    
  end

  def self.down
    rename_table :tipos, :tipo
    rename_table :marcas, :marca
    rename_table :tallas, :talla
    rename_table :colors, :color
    rename_table :inventarios, :inventario

  end
end
