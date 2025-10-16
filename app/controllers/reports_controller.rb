class ReportsController < ApplicationController
  before_action :login_required
  
  def index
    @facturas = Factura.all
    @historias = Historia.where(factura_id: @facturas).includes(:cambios)
  end
end
