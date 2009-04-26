class TipoSweeper < ActionController::Caching::Sweeper
  observe Tipo
  
  def after_save(tipo)
    expire_cache(tipo)
  end
  
  def after_destroy(tipo)
    expire_cache(tipo)
  end
  
  def expire_cache(tipo)
    expire_page buscar_index_path
    expire_page new_buscar_path
  end
end