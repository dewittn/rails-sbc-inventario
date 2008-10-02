class RenameReinvetariadoToNecesitaReinventariarse < ActiveRecord::Migration
  def self.up
    rename_column :inventario, :reinventariado, :necesita_reinventariarse
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration        
  end
end
