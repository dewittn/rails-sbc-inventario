class Orden < ActiveRecord::Base
  def self.find_or_create(args)
    nombre = args[:nombre]
    numero = args[:numero]
    (nombre && numero) ? find(:first,:conditions => ["nombre = ? AND numero = ?",nombre,numero]) || create(:nombre => nombre, :numero => numero) : nil
  end
end
