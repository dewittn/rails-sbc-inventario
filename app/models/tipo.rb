class Tipo < ActiveRecord::Base
  after_save :delete_cache

  def self.all_cached
    Rails.cache.fetch('Tipo') { all }
  end
  
  private
  
  def delete_cahce
    Rails.cache.delete('tipos')
  end
end
