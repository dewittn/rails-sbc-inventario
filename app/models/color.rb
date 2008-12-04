class Color < ActiveRecord::Base
  after_save :delete_cache

  def self.all_cached
    Rails.cache.fetch('color') { all }
  end
  
  private
  
  def delete_cahce
    Rails.cache.delete('color')
  end
end
