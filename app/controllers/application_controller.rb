class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper :all
  include AuthenticatedSystem
  # ExceptionNotifiable is now configured differently in Rails 4.2

  def search_inventory
    @por_sacar = Inventario.find(session[:por_sacar]) unless session[:por_sacar].blank?
    @inventarios = Inventario.pag_search(search_parmas)
  end

  def search_parmas
    read_values(:color_id, :tipo_id, :talla_id, :marca_id, :genero_id, :estilo_id, :row, :column, :id, :page).merge(!params[:updated_at].blank? ? {order: :updated_at} : {})
  end

  def read_values(*values)
    search = {}
    values.each do |key|
      search = search.merge(key => params[key]) unless params[key].blank?
    end
    search
  end
end
