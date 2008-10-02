class AddEstiloToInventarios < ActiveRecord::Migration
  def self.up
    create_table :estilos, :force => true do |t|
      t.string :descr
      
      t.timestamps
    end
    add_column :inventarios, :estilo_id, :integer
  end

  def self.down
    drop_table :estilos
    remove_column :inventarios, :estilo_id
  end
end
