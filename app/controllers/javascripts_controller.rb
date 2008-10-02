class JavascriptsController < ApplicationController
  def nombre_de_orden
    session[:nombre] = params[:value] unless params[:value].blank? 
    render :partial => 'application/nombre'
  end
  
  def agregar_otro_para_sacar
    id ||= params[:id].split("_")[1].to_i
    session[:por_sacar].blank? ? session[:por_sacar] = [id] : session[:por_sacar] += [id]
    session[:por_sacar].uniq!
    Inventario.update(id, {"por_sacar" => params[:cantidad].to_i}) unless params[:cantidad].blank?
    @sacar ||= Inventario.find(id)
    @por_sacar ||= Inventario.find(session[:por_sacar]) unless session[:por_sacar].blank?
    respond_to(&:js)
  end
  
  def por_sacar
    !session[:por_sacar].blank? ? button_push(params[:commit].split[0]) : redirect_to(buscar_index_path)
  end
  
  def button_push(button)
    if button == "Limpiar"
      session[:por_sacar].each do |id|
       Inventario.update(id, {"por_sacar" => 0})
      end
      clear_session
      respond_to do |wants|
        wants.html { redirect_to(buscar_index_path) }
        wants.js {  }
      end
      
    elsif button == "Sacar"
      session[:nombre].blank? ? @error = "La orden no tiene nombre" : update_or_error(session[:por_sacar])  
      @error = "Codigo #{@message} falta#{ "n" if @faltan.size > 1} cantidad por sacar" unless @faltan.blank?      
      if @error.blank?
        clear_session
        respond_to do |wants|
          wants.js { render :update do |page|
                      page.redirect_to(sacar_index_path)
                      end }
        end
      else
        @por_sacar ||= Inventario.find(session[:por_sacar]) unless session[:por_sacar].blank?
        respond_to(&:js)
      end
    end
  end
  
  def clear_session
    session[:por_sacar] = nil
    session[:nombre] = nil
  end
  
  def cantidad_por_sacar(id)
    params[:inventario]["sacar_#{id}".to_sym].to_i
  end
  
  def update_or_error(por_sacar)
    por_sacar.each do |id|
      if cantidad_por_sacar(id).zero?
        @faltan.blank? ? @faltan = [id] : @faltan += [id]
        @message.blank? ? @message = id.to_s : @message += " y #{id}"
      else
        Inventario.update(id, {"por_sacar" => cantidad_por_sacar(id), "tiene_por_sacar" => true, "nombre_de_orden" => session[:nombre]})
      end
    end
  end
  
  def cantidad_update
    Inventario.update(params[:id], { "por_sacar" => params[:cantidad].to_i }) unless params[:cantidad].blank?
  end
  
end
