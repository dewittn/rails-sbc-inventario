class AddNombreDeOrdenToInventario < ActiveRecord::Migration
  def self.up
    add_column :inventario, :nombre_de_orden, :string
  end

  def self.down
    remove_column :inventario, :nombre_de_orden  
  end
end
