class AvanzadoController < ApplicationController
  before_action :login_required
  
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
      if @inventario.update(inventario_params)
        flash[:notice] = 'Chapter was successfully updated.'
        redirect_to avanzado_path(params[:id])
      else
        render action: "edit"
      end
  end

  def create
    @inventario = Inventario.new(inventario_params)
    @inventario.save ? flash[:notice] = "El registro con codigo <b>#{@inventario.id.to_s}</b> se creo exitosamente" : render(action: 'new')
  end
  
  def destroy
    Inventario.update(params[:id], {"por_sacar" => 0})
    flash[:notice] = "El paquete ha sido marcado como eliminado"
    redirect_to avanzado_index_path
  end

  private

  def inventario_params
    params.require(:inventario).permit(:tipo_id, :color_id, :marca_id, :talla_id, :cantidad,
                                       :estilo_id, :genero_id, :row, :column, :por_sacar,
                                       :nombre_de_orden, :numero_de_orden, :numero_de_factura, :fecha)
  end
end
