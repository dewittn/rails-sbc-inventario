class ReportsController < ApplicationController
  before_action :login_required
  
  def index
    @facturas = Factura.all
    @historias = Historia.all( :conditions => { :factura_id => @facturas } ,:include => :cambios)
  end
end
