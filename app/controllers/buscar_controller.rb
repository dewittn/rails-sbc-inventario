class BuscarController < ApplicationController
  # Page caching still works in Rails 4.2 but may need additional gem
  caches_page :index, :new, if: Proc.new { |c| !c.request.format.js? }

  def index
    expires_in 1.hour unless request.format.js?
    search_inventory if params[:commit]
  end

  def create
    @inventario = Inventario.new(inventario_params)
    if @inventario.save
      flash[:notice] = "El registro con codigo <b>#{@inventario.id.to_s}</b> se creo exitosamente"
    else
      render action: 'new'
    end
  end

  def update
    @inventario ||= Inventario.find(params[:id])
    if @inventario.update(inventario_params)
      flash[:notice] = 'Chapter was successfully updated.'
      redirect_to buscar_path(params[:id])
    else
      render action: "edit"
    end
  end

  def show
    @inventario ||= Inventario.find(params[:id])
  end

  private

  def inventario_params
    params.require(:inventario).permit(:tipo_id, :color_id, :marca_id, :talla_id, :cantidad,
                                       :estilo_id, :genero_id, :row, :column, :por_sacar,
                                       :nombre_de_orden, :numero_de_orden, :numero_de_factura, :fecha)
  end
end