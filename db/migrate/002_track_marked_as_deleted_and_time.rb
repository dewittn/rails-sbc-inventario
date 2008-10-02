class TrackMarkedAsDeletedAndTime < ActiveRecord::Migration
  def self.up
    Inventario.transaction do
      add_column :inventario, :eliminado, :boolean, :default => false, :null => false
      add_column :inventario, :created_at, :datetime
      add_column :inventario, :updated_at, :datetime
      add_column :inventario, :eliminado_at, :datetime
      Inventario.find(:all).each do |m|
        m.eliminado = false
        m.created_at = Time.now
        m.save
      end    
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration    
  end
end
