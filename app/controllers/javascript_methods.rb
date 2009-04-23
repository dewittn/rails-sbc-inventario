module JavascriptMethods
  def update_inventario(attributes)
    items = {}
    session[:por_sacar].each do |id|
      items.merge!({id => attributes }) 
    end
    Inventario.update(items.keys, items.values)
  end
  
  def session_por_sacar
     session[:por_sacar] ||= []
   end

   def find_por_sacar
     @por_sacar ||= Inventario.find(session_por_sacar) unless session[:por_sacar].blank?
   end

   def id
     params[:id].split("_")[1].to_i rescue nil
   end

   def clear_session
     session[:por_sacar] = []
     session[:nombre] = nil
     session[:numero] = nil
   end
end