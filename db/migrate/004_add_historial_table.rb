class AddHistorialTable < ActiveRecord::Migration
  def self.up
    create_table :historial do |t|
      t.column :inventario_id, :integer
      t.column :created_at, :datetime
      t.column :cantidad_original, :integer
    end
  end

  def self.down
    drop_table :historial
  end
end
