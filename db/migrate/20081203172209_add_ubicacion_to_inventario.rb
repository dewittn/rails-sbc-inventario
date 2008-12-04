class AddUbicacionToInventario < ActiveRecord::Migration
  def self.up
    add_column :inventarios, :ubicacion_id, :integer
  end

  def self.down
    remove_column :inventarios, :ubicacion_id
  end
end
