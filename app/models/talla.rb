class Talla < ActiveRecord::Base
  after_save :delete_cache

  def self.all_cached
    Rails.cache.fetch('talla') { all }
  end
  
  private
  
  def delete_cahce
    Rails.cache.delete('talla')
  end
end
