class AddIndexesToInventario < ActiveRecord::Migration
  def self.up
    add_index :inventarios, :color_id
    add_index :inventarios, :talla_id
    add_index :inventarios, :tipo_id
    add_index :inventarios, :marca_id
    add_index :inventarios, :estilo_id
    add_index :inventarios, :genero_id
  end

  def self.down
    remove_index :inventarios, :genero_id
    remove_index :inventarios, :estilo_id
    remove_index :inventarios, :marca_id
    remove_index :inventarios, :tipo_id
    remove_index :inventarios, :talla_id
    remove_index :inventarios, :color_id
  end
end
