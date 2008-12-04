class Estilo < ActiveRecord::Base
  after_save :delete_cache

  def self.all_cached
    Rails.cache.fetch('estilo') { all }
  end
  
  private
  
  def delete_cahce
    Rails.cache.delete('estilo')
  end
end
