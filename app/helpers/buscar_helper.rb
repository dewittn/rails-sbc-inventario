module BuscarHelper
  def solicitadas
    if not @solicitadas.nil? 
      n = (@total.to_i - @solicitadas) 
      content_for :solicitadas do
      	if n < 0 
      		"<p style='color: red'>Har&iacute;an falta <b>#{n.abs}</b> camisas para poder satisfacer la cantidad especificada ( #{@solicitadas} )"
      	 else
      		"<p style='color: green'>Sobrar&iacute;an <b>#{n.abs}</b> camisas despu&eacute;s de satisfacer la cantidad especificada ( #{@solicitadas} )</p>"		
      	end
    	end
    end
  end 

end
