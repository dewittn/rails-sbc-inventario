class Inventario < ActiveRecord::Base
  validates_presence_of :marca_id, :tipo_id, :color_id, :talla_id, :cantidad #, :fila, :columna
  validates_numericality_of :cantidad
  validates_numericality_of :columna, :if => :columna_required?
  belongs_to :color
  belongs_to :marca
  belongs_to :talla
  belongs_to :tipo
  has_many :historial
  validates_numericality_of :por_sacar  
  
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
  
end
