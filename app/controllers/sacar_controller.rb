class SacarController < ApplicationController
  def index
    @inventarios = Inventario.por_sacar(params[:page])
  end
  
  def edit
    Inventario.update(id, {"por_sacar" => 0, "nombre_de_orden" => nil})
    redirect_to sacar_index_path
  end
  
  def update
    if params[:cantidad].to_i <= 0
      Inventario.destroy(id)
      redirect_to sacar_index_path
    else
      @inventario = Inventario.update(id, {:cantidad => params[:cantidad], :por_sacar => 0, :nombre_de_orden => nil, :record_historia => true})
    end
  end
  
  def destroy
    Inventario.update(id, {"por_sacar" => 0})
    flash[:notice] = "El paquete ha sido marcado como eliminado"
    redirect_to sacar_index_path
  end
    
  def id
    params[:id].to_i
  end
end
