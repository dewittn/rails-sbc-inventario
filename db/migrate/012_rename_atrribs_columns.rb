class RenameAtrribsColumns < ActiveRecord::Migration
  def self.up
    rename_column :colors, :color, :descr
    rename_column :marcas, :marca, :descr
    rename_column :tallas, :talla, :descr
    rename_column :tipos, :tipo, :descr
  end

  def self.down
    rename_column :tipos, :descr, :tipo
    rename_column :tallas, :descr, :talla
    rename_column :marcas, :descr, :marca
    rename_column :colors, :descr, :color

  end
end
