class CreateCambios < ActiveRecord::Migration
  def self.up
    create_table :cambios do |t|
      t.integer :cambio
      t.integer :cantidad
      t.references :historia
      t.references :orden
      
      t.timestamps
    end
  end

  def self.down
    drop_table :cambios
  end
end
