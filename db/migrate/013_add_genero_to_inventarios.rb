class AddGeneroToInventarios < ActiveRecord::Migration
  def self.up
    add_column :inventarios, :genero_id, :integer
    create_table :generos, :force => true do |t|
      t.string :descr
      t.timestamps
    end
  end

  def self.down
    drop_table :generos
    remove_column :inventarios, :genero_id
  end
end
