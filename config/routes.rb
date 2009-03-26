ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users

  map.resource :session

  map.resources :reinventariar, :avanzado, :buscar
  map.resources :sacar, :collection => {:sacar_temporal => :put}
  map.resources :javascripts, :collection => { :nombre_de_orden => :post, :numero_de_orden => :post, :por_sacar => :post, :agregar_otro_para_sacar => :post, :cantidad_update =>:post, :factura => :post, }
  
  map.nuevo '/nuevo', :controller => 'buscar', :action => 'new'
  
  # map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users, :only => [:new,:create]

  map.resource :session, :only => [:new,:create,:destroy]

  map.resources :admin, :only => [:index]
  map.resources :settings, :only => [:index]
  map.resources :marcas, :colores, :tipos, :tallas, :estilos, :generos, :except => [:show]

end
