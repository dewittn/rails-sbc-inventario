# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include AuthenticatedSystem
  include ExceptionNotifiable
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery #:secret => 'c4536d30cce99bc9f8e7b261ca5b15d9'
  
  def search_inventory
    @por_sacar = Inventario.find(session[:por_sacar]) unless session[:por_sacar].blank?
    @inventarios = Inventario.pag_search(search_parmas)
  end
  
  def search_parmas
    read_values(:color_id, :tipo_id, :talla_id, :marca_id, :genero_id, :estilo_id, :row, :column, :id).merge(!params[:updated_at].blank? ? {:order => :updated_at} : {})
  end
  
  def read_values(*values)
    search = {}
    values.each do |key|
      search = search.merge(key => params[key]) unless params[key].blank?
    end
    search
  end
end
