# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090114023932) do

  create_table "colors", :force => true do |t|
    t.string "descr", :limit => 250
  end

  create_table "estilos", :force => true do |t|
    t.string   "descr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facturas", :force => true do |t|
    t.text     "descr"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fecha"
  end

  create_table "generos", :force => true do |t|
    t.string   "descr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "historias", :force => true do |t|
    t.integer  "cantidad"
    t.text     "talla"
    t.text     "marca"
    t.text     "estillo"
    t.text     "tipo"
    t.text     "genetico"
    t.text     "factura"
    t.text     "ubicacion"
    t.integer  "factura_id"
    t.integer  "inventario_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
  end

  create_table "inventarios", :force => true do |t|
    t.integer  "tipo_id",                                     :null => false
    t.integer  "color_id",                                    :null => false
    t.integer  "marca_id",                                    :null => false
    t.integer  "talla_id",                                    :null => false
    t.integer  "cantidad",                                    :null => false
    t.boolean  "eliminado",                :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "eliminado_at"
    t.boolean  "necesita_reinventariarse"
    t.integer  "por_sacar",                :default => 0
    t.boolean  "tiene_por_sacar",          :default => false
    t.string   "nombre_de_orden"
    t.integer  "estilo_id"
    t.integer  "genero_id"
    t.integer  "ubicacion_id"
    t.integer  "factura_id"
    t.string   "numero_de_orden"
  end

  add_index "inventarios", ["color_id"], :name => "index_inventarios_on_color_id"
  add_index "inventarios", ["estilo_id"], :name => "index_inventarios_on_estilo_id"
  add_index "inventarios", ["genero_id"], :name => "index_inventarios_on_genero_id"
  add_index "inventarios", ["marca_id"], :name => "index_inventarios_on_marca_id"
  add_index "inventarios", ["talla_id"], :name => "index_inventarios_on_talla_id"
  add_index "inventarios", ["tipo_id"], :name => "index_inventarios_on_tipo_id"

  create_table "marcas", :force => true do |t|
    t.string "descr", :limit => 250
  end

  create_table "tallas", :force => true do |t|
    t.string "descr", :limit => 250
  end

  create_table "tipos", :force => true do |t|
    t.string "descr", :limit => 250
  end

  create_table "ubicacions", :force => true do |t|
    t.text     "descr"
    t.string   "fila"
    t.string   "columna"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
