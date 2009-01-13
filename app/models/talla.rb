class Talla < ActiveRecord::Base
  after_save :delete_cache

  def self.all_cached
    Rails.cache.fetch('talla') { all }
  end
  
  private
  
  def delete_cahce
    Rails.cache.delete('talla')
  end
  
  def self.detect_from_cached(id)
    all_cached.detect{ |m| m['id'] == id }.descr rescue nil
  end
end
