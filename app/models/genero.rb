class Genero < ActiveRecord::Base
  after_save :delete_cache

  def self.all_cached
    Rails.cache.fetch('genero') { all }
  end
  
  private
  
  def delete_cahce
    Rails.cache.delete('genero')
  end
end
