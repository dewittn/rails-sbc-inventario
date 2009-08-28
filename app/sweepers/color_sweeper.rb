class ColorSweeper < ActionController::Caching::Sweeper
  observe Color
  
  def after_save(color)
    expire_cache(color)
  end
  
  def after_destroy(color)
    expire_cache(color)
  end
  
  def expire_cache(color)
    expire_page buscar_index_path
    expire_page new_buscar_path
  end
end