Rails.application.routes.draw do
  resources :reinventariar, :avanzado, :buscar
  resources :sacar do
    collection do
      put :sacar_temporal
    end
  end

  resources :javascripts, only: [] do
    collection do
      post :nombre_de_orden
      post :numero_de_orden
      post :por_sacar
      post :agregar_otro_para_sacar
      post :cantidad_update
      post :factura
      post :reinventariar
      post :limpiar
    end
  end

  get '/nuevo', to: 'buscar#new', as: :nuevo
  get '/logout', to: 'sessions#destroy', as: :logout
  get '/login', to: 'sessions#new', as: :login
  post '/register', to: 'users#create', as: :register
  get '/signup', to: 'users#new', as: :signup

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :admin, only: [:index]
  resources :reports, only: [:index]
  resources :settings, only: [:index]
  resources :marcas, :colores, :tipos, :tallas, :estilos, :generos, except: [:show]

  root 'buscar#index'
end
