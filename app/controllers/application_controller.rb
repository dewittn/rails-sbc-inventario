# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include AuthenticatedSystem
  include ExceptionNotifiable
  include CotoSearch
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery #:secret => 'c4536d30cce99bc9f8e7b261ca5b15d9'
  
  def search_vars
    @por_sacar ||= Inventario.find(session[:por_sacar]) unless session[:por_sacar].blank?
    @inventarios ||= Inventario.pag_search(params[:page], @sql)
    @total ||= Inventario.count_camisas(@sql) 
    @solicitadas ||= params[:cantidad].to_i unless params[:cantidad].blank?
    @ubicaciones = Ubicacion.all_cached
  end
end
