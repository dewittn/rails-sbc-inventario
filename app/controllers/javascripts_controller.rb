class JavascriptsController < ApplicationController
  include JavascriptMethods
  
  def cantidad_update
    Inventario.update(params[:id], :por_sacar => params[:por_sacar])
  end
  
  def nombre_de_orden
    session[:nombre] = params[:value] unless params[:value].blank?
    render :text => (session[:nombre].blank? ? "(agregue el nombre)" : session[:nombre].titlecase)
  end
  
  def numero_de_orden
    session[:numero] = params[:value] unless params[:value].blank? 
    render :text => (session[:numero].blank? ? "(agregue el numero)" : session[:numero].titlecase)
  end
  
  def agregar_otro_para_sacar
    if id
      session_por_sacar << id
      session_por_sacar.uniq!
      Inventario.update(id, {"por_sacar" => params[:cantidad].to_i}) unless params[:cantidad].blank?
      @sacar ||= Inventario.find(id)
    end
    find_por_sacar
  end
  
  def por_sacar
    update_inventario({:nombre_de_orden => session[:nombre], :numero_de_orden => session[:numero]})
    clear_session
  end
  
  def limpiar
    unless session[:por_sacar].blank?
      update_inventario({:por_sacar => 0})
      clear_session
    end
  end
  
  def factura
      session[:factura] = !params[:value].blank? ? params[:value] : Time.now.strftime("%d-%m-%Y")
  end
end