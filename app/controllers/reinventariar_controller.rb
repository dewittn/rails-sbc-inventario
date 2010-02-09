class ReinventariarController < ApplicationController
  before_filter :login_required
  
  def index
  	session[:row] = params[:row].upcase unless params[:row].blank?
  	session[:column] = params[:column] unless params[:column].blank?
    @inventarios = Inventario.pag_search( !params[:id].blank? ? read_values(:id) : {:row => session[:row], :column => session[:column], :per_page => 50}) if params[:commit] == "Buscar"
  	@last = Inventario.find(session[:last]) unless session[:last].blank?
  end
  
  def show
    @inventario ||= Inventario.find(params[:id])
  end
  
  def edit
    @inventario ||= Inventario.find(params[:id])
    session[:last] = params[:id]
  end
  
  def update
    @inventario ||= Inventario.find(params[:id])
    @inventario.record_historia = true
      if @inventario.update_attributes(params[:inventario])
        flash[:notice] = 'Inventory was successfully updated.'
      else
        render :action => "edit"
      end
      redirect_to reinventariar_index_path(:commit => "Buscar")
  end

  def create
    @inventario = Inventario.new(params[:inventario])
    @inventario.save ? flash[:notice] = "El registro con código <b>#{@inventario.id.to_s}</b> se creó exitosamente" : render(:action => 'new')
  end
  
  def destroy
    Inventario.update(params[:id], {:row => nil, :column => nil})
    flash[:notice] = "El paquete ha sido marcado como eliminado"
    redirect_to reinventariar_index_path(:commit => "Buscar")
  end
end
