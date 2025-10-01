class Factura < ApplicationRecord
  has_many :historias
  
  def historia_por_report(arry)
    arry.select{ |h| h[:factura_id] == id  }
  end
end
