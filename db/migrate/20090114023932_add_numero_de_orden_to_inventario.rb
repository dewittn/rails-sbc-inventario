class AddNumeroDeOrdenToInventario < ActiveRecord::Migration
  def self.up
    add_column :inventarios, :numero_de_orden, :string
  end

  def self.down
    remove_column :inventarios, :numero_de_orden
  end
end
