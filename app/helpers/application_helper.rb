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
  			<td>#{text_field_tag("fila", {}, {:size => 3, :value => params[:fila]})}</td>
  			<td>#{text_field_tag("columna", {}, {:size => 3, :value => params[:columna]})}</td>"
  		end
  		content_for :avanzado_results_label do
  		  "<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>	
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
  		    "<td>#{h(inventario.id)}</td>						
  		    <td>#{h(@ubicaciones.detect{ |u| u['id'] == inventario.ubicacion_id }.fila)}</td>
  		    <td>#{h(@ubicaciones.detect{ |u| u['id'] == inventario.ubicacion_id }.columna)}</td>
  		    <td>#{link_to 'Mostrar', :action => 'show', :id => inventario}</td>	
  		    <td>#{link_to 'Editar', :action => 'edit', :id => inventario}</td>
  		    <td>#{link_to 'Retirar', avanzado_path(inventario),:confirm => "Est&aacute;s seguro?", :id => inventario, :method => :delete}</td>"
  		  end   
  	end 
  end
  
  def location
    content_for :location do
      render :partial => 'location'
		end
  end

  def cantidad
    params[:cantidad] unless params[:cantidad].blank?
  end
  
  def nombre_de_orden
    session[:nombre].blank? ? "(agregue el nombre)" : session[:nombre].titlecase
  end
  
  def ajax_button_2(text)
    content_for(:button2) do
      "<td>#{link_to_function "<div id='ajax_button_#{text.split[0].downcase}' class='three'><center>#{text}</center></div>" do |page|
        page.insert_html :bottom, :por_sacar, hidden_field_tag('commit',text)
        page << "new Ajax.Request('/javascripts/por_sacar', {asynchronous:true, evalScripts:true, parameters:Form.serialize(document.forms[1]) + '&amp;authenticity_token=' + encodeURIComponent('#{escape_javascript form_authenticity_token}')}); return false;"
      end}</td>"
		end
  end
  
  def make_dragable
    drop_receiving_element("por_sacar", :url => { :controller => "javascripts", :action => "agregar_otro_para_sacar", :params => { :cantidad => params[:cantidad] } })
  end
  
  def cantidad_txt_field
    text_field 'inventario', 'cantidad', {:size => 3, :maxlength => 3, :value => get_value(params[:cantidad]), :id => 'cantidad', :name => 'cantidad'}
  end
  
  def get_value(value)
    value.blank?  ? '' : value
  end
  
  def descr_from_cashed_values(model,id)
    model.detect_from_cached(id)
  end
    
end
