class ModifyFacutraYInventario < ActiveRecord::Migration
  def self.up
    remove_column :inventarios, :row
    remove_column :inventarios, :column 
    add_column :facturas, :fecha, :string
    add_column :inventarios, :factura_id, :integer
  end

  def self.down
    remove_column :inventarios, :factura_id
    remove_column :facturas, :fecha
    add_column :inventarios, :column, :integer
    add_column :inventarios, :row, :string
  end
end
