class BuscarController < ApplicationController  
  caches_page :index, :new, :if => Proc.new { |c| !c.request.format.js? }
  
  def index
    expires_in 1.hour unless request.format.js?
    @sql ||= build_sql(Color,Marca,Genero,Estilo,Tipo,Talla,:codigo_id) 
    search_vars if params[:commit]
  end
  
  def create
    @inventario = Inventario.new(params[:inventario])
    @inventario.save ? flash[:notice] = "El registro con código <b>#{@inventario.id.to_s}</b> se creó exitosamente" : render(:action => 'new')
  end
  
  def update
    @inventario ||= Inventario.find(params[:id])
    respond_to do |format| 
      if @inventario.update_attributes(params[:inventario])
        flash[:notice] = 'Chapter was successfully updated.'
        format.html { redirect_to buscar_path(params[:id]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inventario.errors.to_xml }
      end
    end
  end
  
  def show
    @inventario ||= Inventario.find(params[:id])
  end
end
