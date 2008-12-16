class JavascriptsController < ApplicationController
  include JavascriptMethods
  
  def nombre_de_orden
    session[:nombre] = params[:value] unless params[:value].blank? 
    render :text => (session[:nombre].blank? ? "(agregue el nombre)" : session[:nombre].titlecase)
  end
  
  def agregar_otro_para_sacar
    session_por_sacar << id
    session_por_sacar.uniq!
    Inventario.update(id, {"por_sacar" => params[:cantidad].to_i}) unless params[:cantidad].blank?
    @sacar ||= Inventario.find(id)
    find_por_sacar
  end
  
  def por_sacar
    (button_push == "Sacar" ? sacar : limpiar) unless session[:por_sacar].blank?
  end
end