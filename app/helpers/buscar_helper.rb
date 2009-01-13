module BuscarHelper
  def solicitadas
    if !@solicitadas.blank?
      	if total< 0 
      		"<p style='color: red'>Har&iacute;an falta <b>#{total.abs}</b> camisas para poder satisfacer la cantidad especificada ( #{@solicitadas} )"
      	 else
      		"<p style='color: green'>Sobrar&iacute;an <b>#{total.abs}</b> camisas despu&eacute;s de satisfacer la cantidad especificada ( #{@solicitadas} )</p>"		
      	end
    end
  end 
  
  def total
    @total_solicitadas ||= (@total.to_i - @solicitadas)
  end
  
  def factura
    session[:factura] || Time.now.strftime("%d-%m-%Y")
  end

end
