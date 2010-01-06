class AddRowAndColumnToInventario < ActiveRecord::Migration
  def self.up
    add_column :inventarios, :row, :string
    add_column :inventarios, :column, :string
    add_index :inventarios, :row
    add_index :inventarios, :column
    Inventario.find_each(&:location_update)
  end

  def self.down
    remove_index :inventarios, :column
    remove_index :inventarios, :row
    remove_column :inventarios, :column
    remove_column :inventarios, :row
  end
end
