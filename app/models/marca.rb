class Marca < ActiveRecord::Base
  after_save :delete_cache
  
  def self.all_cached
    Rails.cache.fetch('marca') { all }
  end
  
  private
  
  def delete_cahce
    Rails.cache.delete('marca')
  end
  
  def self.detect_from_cached(id)
    all_cached.detect{ |m| m['id'] == id }.descr
  end
end
