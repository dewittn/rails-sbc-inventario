class RemoveUbicacion < ActiveRecord::Migration
  def self.up
    drop_table :ubicacions
    remove_column :inventarios, :ubicacion_id
  end

  def self.down
    add_column :inventarios, :ubicacion_id, :integer
    create_table "ubicacions", :force => true do |t|
      t.text     "descr"
      t.string   "fila"
      t.string   "columna"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
