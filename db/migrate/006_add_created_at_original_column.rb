class AddCreatedAtOriginalColumn < ActiveRecord::Migration
  def self.up
    add_column :historial, :created_at_original, :datetime
  end

  def self.down
    remove_column :historial, :created_at_original
  end
end
