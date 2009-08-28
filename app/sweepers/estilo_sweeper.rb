class EstiloSweeper < ActionController::Caching::Sweeper
  observe Estilo
  
  def after_save(estilo)
    expire_cache(estilo)
  end
  
  def after_destroy(estilo)
    expire_cache(estilo)
  end
  
  def expire_cache(estilo)
    expire_page buscar_index_path
    expire_page new_buscar_path
  end
end