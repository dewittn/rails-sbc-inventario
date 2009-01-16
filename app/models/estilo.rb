class Estilo < ActiveRecord::Base
  after_save :delete_cached
  after_destroy :delete_cached
  validates_presence_of :descr

  def self.all_cached
    Rails.cache.fetch('estilo') { all }
  end
  
  private
  
  def delete_cached
    Rails.cache.delete('estilo')
  end
end
