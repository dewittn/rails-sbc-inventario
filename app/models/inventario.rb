class Inventario < ActiveRecord::Base  
  before_save :find_or_create_ubcicion
  after_create :create_history
  
  validates_presence_of :talla_id, :color_id, :tipo_id, :marca_id, :estillo_id, :factura_id, :genetico_id 
  
  has_one :historia
  
  belongs_to :tipo
  belongs_to :color
  belongs_to :talla
  belongs_to :factura
  belongs_to :estillo
  belongs_to :factura
  belongs_to :marca
  belongs_to :ubicacion
  
  def columna_required?
    not columna.blank?
  end
  
  def self.por_sacar(page)
    paginate :per_page => 10,:page => page, :conditions => "tiene_por_sacar = true AND eliminado = false", :order => "nombre_de_orden ASC"
  end
  
  def self.reinventario(page)
    paginate :per_page => 10,:page => page, :conditions => "necesita_reinventariarse = true AND eliminado = false"
  end
  
  def self.count_camisas(conditions)
    sum(:cantidad,:conditions => conditions)
  end
  
  def self.temporal
    search("por_sacar > 0 and tiene_por_sacar = false")
  end
  
  def find_or_create__ubcicion
    update_attribute(:ubicacion_id, Ubicacion.find_or_create(:fila => fila, :columna => columna).id) if (fila && columna)
  end
  
end
