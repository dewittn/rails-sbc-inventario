class SacarController < ApplicationController
  def index
    @inventarios = Inventario.por_sacar(params[:page])
    @temporal = Inventario.temporal
  end
  
  def edit
    Inventario.update(id, {"por_sacar" => 0, "tiene_por_sacar" => false, "nombre_de_orden" => nil})
    redirect_to sacar_index_path
  end
  
  def update
    Inventario.update(id, {"por_sacar" => 0, "tiene_por_sacar" => false, "nombre_de_orden" => nil,"necesita_reinventariarse" => true})
    redirect_to edit_reinventariar_path(id)
  end
  
  def destroy
    Inventario.update(id, {"por_sacar" => 0, "tiene_por_sacar" => false, "eliminado" => true,"eliminado_at" => Time.now})
    flash[:notice] = "El paquete ha sido marcado como eliminado"
    redirect_to sacar_index_path
  end
  
  def sacar_temporal
    Inventario.temporal.each do |temporal|
      temporal.update_attribute(:por_sacar, 0)
    end
    redirect_to sacar_index_path
  end
  
  def id
    params[:id].to_i
  end
end
