class MarcaSweeper < ActionController::Caching::Sweeper
  observe Marca
  
  def after_save(marca)
    expire_cache(marca)
  end
  
  def after_destroy(marca)
    expire_cache(marca)
  end
  
  def expire_cache(marca)
    expire_page buscar_index_path
    expire_page new_buscar_path
  end
end