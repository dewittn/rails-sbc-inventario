class AddTienePorSacarColumnToInventario < ActiveRecord::Migration
  def self.up
    add_column :inventario, :tiene_por_sacar, :boolean, :default => false
    #this column is true if someone has RECENTLY marked the item as "por sacar" and so it is not
    #an indicator of if the number of por_sacar is 0 or not
    Inventario.find(:all).each do |m|
      m.tiene_por_sacar = false
      m.save  
    end      
  end

  def self.down
    remove_column :inventario, :tiene_por_sacar    
  end
end
