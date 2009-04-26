class TallaSweeper < ActionController::Caching::Sweeper
  observe Talla
  
  def after_save(talla)
    expire_cache(talla)
  end
  
  def after_destroy(talla)
    expire_cache(talla)
  end
  
  def expire_cache(talla)
    expire_page buscar_index_path
    expire_page new_buscar_path
  end
end