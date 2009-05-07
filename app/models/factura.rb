class Factura < ActiveRecord::Base
  has_many :historias
end
