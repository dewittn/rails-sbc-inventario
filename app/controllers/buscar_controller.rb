class BuscarController < ApplicationController  
  caches_page :index, :new, :if => Proc.new { |c| !c.request.format.js? }
  
  def index
    expires_in 1.hour unless request.format.js?
    search_inventory if params[:commit]
  end
  
  def create
    @inventario = Inventario.new(params[:inventario])
    @inventario.save ? flash[:notice] = "El registro con codigo <b>#{@inventario.id.to_s}</b> se creo exitosamente" : render(:action => 'new')
  end
  
  def update
    @inventario ||= Inventario.find(params[:id])
      if @inventario.update_attributes(params[:inventario])
        flash[:notice] = 'Chapter was successfully updated.'
        redirect_to buscar_path(params[:id])
      else
        render :action => "edit" 
      end
  end
  
  def show
    @inventario ||= Inventario.find(params[:id])
  end
end