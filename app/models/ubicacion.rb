class Ubicacion < ActiveRecord::Base
  after_save :delete_cache
  
  validates_presence_of :columna, :fila

  def descr
    fila + " " + columna.to_s
  end
  
  def self.find_or_create(args)
    fila = args[:fila]
    columna = args[:columna]
    (fila && columna) ? find(:first,:conditions => ["fila = ? AND columna = ?",fila,columna]) || create(:fila => fila, :columna => columna) : nil
  end
  
  def self.all_cached
    Rails.cache.fetch('Ubicacion') { all }
  end

  def self.delete_cahce
    Rails.cache.delete('Ubicacion')
  end
  
  def delete_cahce
    Rails.cache.delete('Ubicacion')
  end
end
