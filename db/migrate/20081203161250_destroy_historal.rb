class DestroyHistoral < ActiveRecord::Migration
  def self.up
    drop_table :historials
  end

  def self.down
    create_table "historials", :force => true do |t|
      t.integer  "inventario_id"
      t.datetime "created_at"
      t.integer  "cantidad_original"
      t.datetime "created_at_original"
    end
    
  end
end
