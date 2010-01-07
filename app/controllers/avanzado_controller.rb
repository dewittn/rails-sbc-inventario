class AvanzadoController < ApplicationController
  before_filter :login_required
  
  def index
    search_inventory if params[:commit]
  end
  
  def show
    @inventario ||= Inventario.find(params[:id])
  end
  
  def edit
    @inventario ||= Inventario.find(params[:id])
  end
  
  def update
    @inventario ||= Inventario.find(params[:id])
    @inventario.record_historia = true
      if @inventario.update_attributes(params[:inventario])
        flash[:notice] = 'Chapter was successfully updated.'
        redirect_to avanzado_path(params[:id])
      else
        render :action => "edit"
      end
  end

  def create
    @inventario = Inventario.new(params[:inventario])
    @inventario.save ? flash[:notice] = "El registro con código <b>#{@inventario.id.to_s}</b> se creó exitosamente" : render(:action => 'new')
  end
  
  def destroy
    Inventario.update(params[:id], {"por_sacar" => 0})
    flash[:notice] = "El paquete ha sido marcado como eliminado"
    redirect_to avanzado_index_path
  end
end
