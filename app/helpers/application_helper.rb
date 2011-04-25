# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include CotoHelper
    
  def avanzado
      content_for :avanzado_search_labels do
        "<th>C&oacute;digo</td>
    	 <th>Fila</th>
    	 <th>Columna</th>"
      end
      content_for :avanzado_search do
        "<td>#{text_field_tag("id", {},{:size => 3, :value => params[:id]})}</td>
  		 <td>#{text_field_tag("row", {}, {:size => 3, :value => params[:fila]})}</td>
  		 <td>#{text_field_tag("column", {}, {:size => 3, :value => params[:columna]})}</td>"
  		end
  		content_for :avanzado_results_label do
  		  "<th></th>
  		   <th>C&oacute;digo</th>	
  		   <th>Fila</th>
  		   <th>Columna</th>
  		   <th></th>
  		   <th></th>"
  		end
  end
  
  def avanzado_results(inventario)
    if params[:controller] == "avanzado"
      content_for "inventario_#{inventario.id}".to_sym do
  		    "<td></td>
  		    <td>#{h(inventario.id)}</td>						
  		    <td>#{h(inventario.row)}</td>
      		<td>#{h(inventario.column)}</td>
  		    <td>#{link_to 'Mostrar', :action => 'show', :id => inventario}</td>	
  		    <td>#{link_to 'Editar', :action => 'edit', :id => inventario}</td>
  		    <td>#{link_to 'Retirar', avanzado_path(inventario),:confirm => "Est&aacute;s seguro?", :id => inventario, :method => :delete}</td>"
  		  end
  	end
  end
  
  def location
      render :partial => 'location' if params[:controller] =="buscar"
  end

  def cantidad
    params[:cantidad] unless params[:cantidad].blank?
  end
  
  def make_dragable
    drop_receiving_element("por_sacar", :url => { :controller => "javascripts", :action => "agregar_otro_para_sacar", :params => { :cantidad => params[:cantidad] } })
  end
  
  def nombre_de_orden
    session[:nombre].blank? ? "(agregue el nombre)" : session[:nombre].titlecase
  end
  
  def numero_de_orden
    session[:numero].blank? ? "(agregue el numero)" : session[:numero].titlecase
  end
  
  def cantidad_txt_field
    text_field 'inventario', 'cantidad', {:size => 3, :maxlength => 3, :value => get_value(params[:cantidad]), :id => 'cantidad', :name => 'cantidad'}
  end
  
  def get_value(value)
    value.blank?  ? '' : value
  end
  
  def draggable(inventario)
    draggable_element("inventario_#{inventario.id}",:revert => true,:ghosting => true)
  end
  
  def descr_from_cashed_values(model,id)
    model.detect_from_cached(id)
  end
  
  def detalles(inventario)
    render :partial => 'application/detalles', :locals => {:inventario => inventario}
  end
  
  def cantidad_por_sacar(inventario)
    " ( #{inventario.por_sacar.to_s} por sacar)" unless inventario.por_sacar == 0 
  end
  
  def resultados_avanzados(inventario)
    ("inventario_#{inventario.id}".to_sym) if params[:controller] == "avanzado"
  end
  
  def total_camisas
    "<p><b>Total:</b> #{(@total.blank?) ? "0": @total } camisas, en #{(@inventarios.total_entries.blank?) ? "0": @inventarios.total_entries} paquetes.</p>" unless @total.blank?
  end
  
  def fila_columna(inventario)
    render :partial => 'application/fila_columna', :locals => {:inventario => inventario}
  end

  def no_cambio(inventario)
    ((Time.now - inventario.updated_at)).to_i / 2592000 rescue "?"
  end
end
