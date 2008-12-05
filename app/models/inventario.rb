class Inventario < ActiveRecord::Base  
  before_save :find_or_create_ubicacion, :find_or_create_factura
  after_create :create_history
  
  validates_presence_of :talla_id, :color_id, :tipo_id, :marca_id, :estilo_id, :genero_id 
  
  has_one :historia
  
  belongs_to :tipo
  belongs_to :talla
  belongs_to :color
  belongs_to :marca
  belongs_to :estillo
  belongs_to :factura
  belongs_to :ubicacion
  
  attr_accessor :factura, :fecha
  
  def fila
    @fila ||= ubicacion_id ? Ubicacion.all_cached.detect{ |u| u['id'] == ubicacion_id }.fila : nil
  end
  
  def fila=(value)
    @fila = value
  end
  
  def columna
    @columna ||= ubicacion_id ? Ubicacion.all_cached.detect{ |u| u['id'] == ubicacion_id }.columna : nil
  end
  
  def columna=(value)
    @columna = value
  end
  
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
  
  def find_or_create_ubicacion
    self.ubicacion_id = Ubicacion.find_or_create(:fila => fila, :columna => columna).id if (fila && columna)
  end
  
  def find_or_create_factura
    self.factura_id = Factura.find_or_create(:descr => factura, :fecha => fecha).id
  end
  
  def create_history
    Historia.create(:cantidad => cantidad,:factura_id => factura_id, :inventario_id => id,
                    :color => (Color.all_chached.detect{ |a| a['id'] == color_id }.descr rescue nil),
                    :talla => (Talla.all_chached.detect{ |a| a['id'] == talla_id }.descr rescue nil),
                    :marca => (Tipo.all_chached.detect{ |a| a['id'] == tipo_id }.descr rescue nil),
                    :genetico => (Marca.all_chached.detect{ |a| a['id'] == marca_id }.descr rescue nil))
  end
  
end
