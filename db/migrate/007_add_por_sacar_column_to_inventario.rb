class AddPorSacarColumnToInventario < ActiveRecord::Migration
  def self.up
    add_column :inventario, :por_sacar, :integer, :default => 0
    Inventario.find(:all).each do |m|
      m.por_sacar = 0
      m.save  
    end    
  end

  def self.down
    remove_column :inventario, :por_sacar
  end
end
