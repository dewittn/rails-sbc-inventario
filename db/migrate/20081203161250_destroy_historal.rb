class DestroyHistoral < ActiveRecord::Migration
  def self.up
    drop_table :historial
  end

  def self.down
    create_table "historial", :force => true do |t|
      t.integer  "inventario_id"
      t.datetime "created_at"
      t.integer  "cantidad_original"
      t.datetime "created_at_original"
    end
    
  end
end
