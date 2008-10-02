class AllowNullLocation < ActiveRecord::Migration
  def self.up
    Inventario.transaction do
      inventarios = Inventario.find(:all)
      remove_column :inventario, :fila
      remove_column :inventario, :columna
      add_column :inventario, :fila, :string, :null => true
      add_column :inventario, :columna, :integer, :null => true
      inventarios.each do |inv|
        inv.save
      end
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
