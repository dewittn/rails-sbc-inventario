class ReinventariarController < ApplicationController
  before_filter :login_required
  
  def index
    redirect_to(avanzado_index_path) if params[:commit] == "Limpiar"
    @sql ||= build_sql(Color,Marca,Genero,Estilo,Tipo,Talla,:id,:fila,:columna)
    search_vars
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
    @inventario.admin_changed = true
    respond_to do |format| 
      if @inventario.update_attributes(params[:inventario])
        flash[:notice] = 'Chapter was successfully updated.'
        format.html { redirect_to avanzado_path(params[:id]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inventario.errors.to_xml }
      end
    end
  end

  def create
    @inventario = Inventario.new(params[:inventario])
    @inventario.save ? flash[:notice] = "El registro con código <b>#{@inventario.id.to_s}</b> se creó exitosamente" : render(:action => 'new')
  end
  
  def destroy
    Inventario.update(params[:id], {"por_sacar" => 0, "tiene_por_sacar" => false, "eliminado" => true,"eliminado_at" => Time.now})
    flash[:notice] = "El paquete ha sido marcado como eliminado"
    redirect_to avanzado_index_path
  end
end
