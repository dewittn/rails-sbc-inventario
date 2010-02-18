class ReinventariarController < ApplicationController
  before_filter :login_required
  
  def index
    if params[:id].blank?
      session[:row] = params[:row].upcase unless params[:row].blank?
      session[:column] = params[:column] unless params[:column].blank?
      @inventarios = Inventario.pag_search({:row => session[:row], :column => session[:column], :per_page => 50}) if params[:commit] == "Buscar"
      @last = Inventario.find(session[:last]) unless session[:last].blank?
   else
      redirect_to edit_reinventariar_path(params[:id])
   end 
  end
  
  def show
    @inventario = Inventario.find(params[:id])                                
  end
  
  def edit
  	begin
      @inventario ||= Inventario.find(params[:id])
      session[:last] = params[:id]
      @similar = Inventario.scoped(:group => "row").pag_search(:color_id => @inventario.color_id, :marca_id => @inventario.marca_id, :per_page => 20)
    rescue
      flash[:notice] = 'Item not found.'
      redirect_to reinventariar_index_path(:commit => "Buscar")
    end
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
    if @inventario.save 
      flash[:notice] = "El registro con código <b>#{@inventario.id.to_s}</b> se creó exitosamente"
      session[:last] = @inventario.id
      @similar = Inventario.scoped(:group => "row").pag_search(:color_id => @inventario.color_id, :marca_id => @inventario.marca_id, :per_page => 20)
    else
     render(:action => 'new')
    end
  end
  
  def destroy
    Inventario.update(params[:id], {:row => nil, :column => nil})
    flash[:notice] = "El paquete ha sido marcado como eliminado"
    redirect_to reinventariar_index_path(:commit => "Buscar")
  end
end
