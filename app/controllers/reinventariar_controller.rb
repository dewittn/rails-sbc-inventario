class ReinventariarController < ApplicationController
  def index
    params[:id].blank? ? @inventarios ||= Inventario.reinventario(params[:page]) : redirect_to(edit_reinventariar_path(params[:id]))
  end
  
  def edit
    @inventarios ||= Inventario.find(id)
  end
  
  def update
    Inventario.update(id, {"cantidad" => params[:cantidad].to_i,"necesita_reinventariarse" => false})
    @inventarios = Inventario.find(id)
  end
  
  def show
  
  end
    
  def id
    params[:id]
  end
end
