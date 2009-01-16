class AddTableHistoriaOrden < ActiveRecord::Migration
  def self.up
    create_table :historias_ordens, :force => true do |t|
      t.references :historia
      t.references :orden
      
      t.timestamps
    end
  end

  def self.down
    drop_table :historias_ordens
  end
end
