# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20100106185925) do

  create_table "cambios", force: :cascade do |t|
    t.integer  "cambio",      limit: 4
    t.integer  "cantidad",    limit: 4
    t.integer  "historia_id", limit: 4
    t.integer  "orden_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colors", force: :cascade do |t|
    t.string "descr", limit: 250
  end

  create_table "estilos", force: :cascade do |t|
    t.string   "descr",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facturas", force: :cascade do |t|
    t.text     "descr",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fecha",      limit: 255
  end

  create_table "generos", force: :cascade do |t|
    t.string   "descr",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "historials", force: :cascade do |t|
    t.integer  "inventario_id",       limit: 4
    t.datetime "created_at"
    t.integer  "cantidad_original",   limit: 4
    t.datetime "created_at_original"
  end

  create_table "historias", force: :cascade do |t|
    t.integer  "cantidad",      limit: 4
    t.text     "talla",         limit: 65535
    t.text     "marca",         limit: 65535
    t.text     "estillo",       limit: 65535
    t.text     "tipo",          limit: 65535
    t.text     "genetico",      limit: 65535
    t.text     "factura",       limit: 65535
    t.text     "ubicacion",     limit: 65535
    t.integer  "factura_id",    limit: 4
    t.integer  "inventario_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color",         limit: 255
  end

  create_table "historias_ordens", force: :cascade do |t|
    t.integer  "historia_id", limit: 4
    t.integer  "orden_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventarios", force: :cascade do |t|
    t.integer  "tipo_id",         limit: 4,               null: false
    t.integer  "color_id",        limit: 4,               null: false
    t.integer  "marca_id",        limit: 4,               null: false
    t.integer  "talla_id",        limit: 4,               null: false
    t.integer  "cantidad",        limit: 4,               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "por_sacar",       limit: 4,   default: 0
    t.string   "nombre_de_orden", limit: 255
    t.integer  "estilo_id",       limit: 4
    t.integer  "genero_id",       limit: 4
    t.integer  "factura_id",      limit: 4
    t.string   "numero_de_orden", limit: 255
    t.string   "row",             limit: 255
    t.string   "column",          limit: 255
  end

  add_index "inventarios", ["color_id"], name: "index_inventarios_on_color_id", using: :btree
  add_index "inventarios", ["column"], name: "index_inventarios_on_column", using: :btree
  add_index "inventarios", ["estilo_id"], name: "index_inventarios_on_estilo_id", using: :btree
  add_index "inventarios", ["genero_id"], name: "index_inventarios_on_genero_id", using: :btree
  add_index "inventarios", ["marca_id"], name: "index_inventarios_on_marca_id", using: :btree
  add_index "inventarios", ["row"], name: "index_inventarios_on_row", using: :btree
  add_index "inventarios", ["talla_id"], name: "index_inventarios_on_talla_id", using: :btree
  add_index "inventarios", ["tipo_id"], name: "index_inventarios_on_tipo_id", using: :btree

  create_table "marcas", force: :cascade do |t|
    t.string "descr", limit: 250
  end

  create_table "ordens", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.string   "numero",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tallas", force: :cascade do |t|
    t.string "descr", limit: 250
  end

  create_table "tipos", force: :cascade do |t|
    t.string "descr", limit: 250
  end

  create_table "users", force: :cascade do |t|
    t.string   "login",                     limit: 40
    t.string   "name",                      limit: 100, default: ""
    t.string   "email",                     limit: 100
    t.string   "crypted_password",          limit: 40
    t.string   "salt",                      limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            limit: 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree

end
