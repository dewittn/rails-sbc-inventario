class ReportsController < ApplicationController
  def index
    @facturas = Factura.all
    @historias = Historia.all(:include => :cambios)
  end
    
end
