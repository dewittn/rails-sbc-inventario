class Inventario < ApplicationRecord  
  before_save :find_or_create_factura, :if  => :update_ids#Proc.new { |i| i.update_ids == true }
  before_save :capitalize
  after_create :create_history
  before_update :record_orden_history, :if => Proc.new { |i| i.record_historia == true }
  before_destroy :record_orden_history_delete
  
  validates_presence_of :talla_id, :color_id, :tipo_id, :marca_id, :estilo_id, :genero_id, :cantidad
  
  has_one :historia
  
  belongs_to :tipo
  belongs_to :talla
  belongs_to :color
  belongs_to :marca
  belongs_to :estillo
  belongs_to :factura
  belongs_to :ubicacion
  
  attr_accessor :numero_de_factura, :fecha, :record_historia, :update_ids
  
  def self.pag_search(arry)
    page = arry.delete(:page) || 1
    per_page = arry.delete(:per_page) || 10
    order = arry.delete(:order) || 'id'
    scope = self.all
    arry.keys.each do |key|
       scope = scope.where(key => arry[key])
    end
    scope.paginate per_page: per_page, page: page, order: order
  end
  
  def capitalize
  	self.row.upcase! rescue nil
  end
  
  def columna_changed?
    (@columna == Ubicacion.all_cached.detect{ |u| u['id'] == ubicacion_id }.columna) rescue false
  end
  
  def columna_required?
    not columna.blank?
  end
  
  def self.por_sacar(page)
    where("por_sacar > 0").order("nombre_de_orden ASC").paginate(per_page: 10, page: page)
  end

  def self.count_camisas(conditions)
    where(conditions).sum(:cantidad)
  end
  
  def find_or_create_factura
    unless factura_id
      self.factura_id = (Factura.find_or_create_by(descr: numero_de_factura, fecha: (fecha || Time.now.strftime("%d-%m-%Y"))).id rescue nil)
    end
  end
  
  def create_history
    Historia.create(:cantidad => cantidad,:factura_id => factura_id, :inventario_id => id,
                    :color => (Color.detect_from_cached(color_id)),
                    :talla => (Talla.detect_from_cached(talla_id)),
                    :marca => (Marca.detect_from_cached(marca_id)),
                    :genetico => (Genero.detect_from_cached(genero_id))) unless factura_id.blank?
  end
  
  def record_orden_history
    if historia_find
      historia_find.cambios.create(:cambio => (cantidad - cantidad_was), :cantidad => cantidad, :orden_id => orden_find_or_create(name_for_history, number_for_history))
    end
  end
  
  #If there is no name on the order (when an admin edits) set the same to "admin"
  def name_for_history
  	nombre_de_orden_was || "admin"
  end
  
  def number_for_history
  	name_for_history != "admin" ? numero_de_orden_was : 0
  end
  
  def record_orden_history_delete
    historia_find.cambios.create(:cambio => (0 - cantidad), :cantidad => 0, :orden_id => orden_find_or_create(nombre_de_orden,numero_de_orden)) if historia_find
  end
  
  def historia_find
    @historia ||= Historia.find_by_inventario_id(id)
  end
  
  def orden_find_or_create(nombre,numero)
    Orden.find_or_create(:nombre => nombre,:numero => numero).id
  end
  
  def location_update
    self.row = ubicacion.fila rescue nil
    self.column = ubicacion.columna rescue nil
    save!
  end
end
