class RemoveBooleansFromInventory < ActiveRecord::Migration
  def self.up
    remove_column :inventarios, :eliminado
    remove_column :inventarios, :eliminado_at
    remove_column :inventarios, :necesita_reinventariarse
    remove_column :inventarios, :tiene_por_sacar
  end

  def self.down
    add_column :inventarios, :tiene_por_sacar, :boolean,          :default => false
    add_column :inventarios, :necesita_reinventariarse, :boolean
    add_column :inventarios, :eliminado_at, :datetime
    add_column :inventarios, :eliminado, :boolean,                :default => false, :null => false
  end
end
