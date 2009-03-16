class RenameFilaYColumna < ActiveRecord::Migration
  def self.up
    rename_column :inventarios, :fila, :row
    rename_column :inventarios, :columna, :column
  end

  def self.down
    rename_column :inventarios, :column, :columna
    rename_column :inventarios, :row, :fila
  end
end
