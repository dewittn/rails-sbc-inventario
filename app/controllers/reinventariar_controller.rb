class ReinventariarController < ApplicationController
  before_filter :login_required
  
  def index
    if params[:commit] == "Buscar"
      @sql = build_sql(:id,:row,:column)
      @inventarios = Inventario.pag_search(params[:page], @sql)
      @total = Inventario.count_camisas(@sql) 
      @solicitadas = params[:cantidad].to_i unless params[:cantidad].blank?
    end
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
      else
        render :action => "edit"
      end
  end

  def create
    @inventario = Inventario.new(params[:inventario])
    @inventario.save ? flash[:notice] = "El registro con código <b>#{@inventario.id.to_s}</b> se creó exitosamente" : render(:action => 'new')
  end
  
  def destroy
    Inventario.update(params[:id], {:row => nil, :column => nil})
    flash[:notice] = "El paquete ha sido marcado como eliminado"
    redirect_to reinventariar_index_path
  end
end
