class GeneroSweeper < ActionController::Caching::Sweeper
  observe Genero
  
  def after_save(genero)
    expire_cache(genero)
  end
  
  def after_destroy(genero)
    expire_cache(genero)
  end
  
  def expire_cache(genero)
    expire_page buscar_index_path
    expire_page new_buscar_path
  end
end