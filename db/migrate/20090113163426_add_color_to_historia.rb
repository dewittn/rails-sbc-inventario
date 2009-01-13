class AddColorToHistoria < ActiveRecord::Migration
  def self.up
    add_column :historias, :color, :string
  end

  def self.down
    remove_column :historias, :color
  end
end
