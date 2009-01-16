class CreateOrdens < ActiveRecord::Migration
  def self.up
    create_table :ordens do |t|
      t.string :nombre
      t.string :numero
      
      t.timestamps
    end
  end

  def self.down
    drop_table :ordens
  end
end
