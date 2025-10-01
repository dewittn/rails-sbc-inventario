class Orden < ApplicationRecord
  def self.find_or_create(args)
    nombre = args[:nombre]
    numero = args[:numero]
    (nombre && numero) ? where(nombre: nombre, numero: numero).first || create(nombre: nombre, numero: numero) : nil
  end
end
