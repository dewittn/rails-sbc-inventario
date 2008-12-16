module JavascriptMethods
  def session_por_sacar
     session[:por_sacar] ||= []
   end

   def find_por_sacar
     @por_sacar ||= Inventario.find(session_por_sacar) unless session[:por_sacar].blank?
   end

   def id
     params[:id].split("_")[1].to_i
   end

   def sacar 
     update ? clear_session : find_por_sacar
   end

   def limpiar
     session_por_sacar.each do |id|
      Inventario.update(id, {"por_sacar" => 0})
     end
     clear_session
   end

   def clear_session
     session[:por_sacar] = []
     session[:nombre] = nil
   end

   def cantidad_por_sacar(id)
     params[:inventario]["sacar_#{id}".to_sym].to_i
   end

   def update
     if session[:nombre].blank? 
       @error = "La orden no tiene nombre"
     else
       session_por_sacar.each do |id|
         faltan << id  if cantidad_por_sacar(id).zero?
       end
       @error = "Codigo #{message} falta#{ "n" if faltan.size > 1} cantidad por sacar" unless faltan.blank? 
       session_por_sacar.each do |id|
          Inventario.update(id, {"por_sacar" => cantidad_por_sacar(id), "tiene_por_sacar" => true, "nombre_de_orden" => session[:nombre]}) if faltan.blank?
        end
     end
     @error.blank?
   end

   def message
     faltan.each do |id|
       @message.blank? ? @message = id.to_s : @message += " y #{id}"
     end
   end

   def faltan
     @faltan ||= []
   end

   def button_push
     @button_push ||= params[:commit].split[0]
   end
end