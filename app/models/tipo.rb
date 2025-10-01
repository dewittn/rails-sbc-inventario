class Tipo < ApplicationRecord
  after_save :delete_cached
  after_destroy :delete_cached
  validates_presence_of :descr

  def self.all_cached
    Rails.cache.fetch('Tipo') { all }
  end
  
  private
  
  def delete_cached
    Rails.cache.delete('tipos')
  end
  
  def self.detect_from_cached(id)
    all_cached.detect{ |m| m['id'] == id }.descr rescue nil
  end
end
