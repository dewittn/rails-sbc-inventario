class AddReinventariadoColumn < ActiveRecord::Migration
  def self.up
    Inventario.transaction do
      add_column :inventario, :reinventariado, :boolean
      Inventario.find(:all).each do |m|
        m.reinventariado = false
        m.save  
      end
    end
  end

  def self.down
    remove_column :inventario, :reinventariado
  end
end
