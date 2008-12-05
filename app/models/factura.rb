class Factura < ActiveRecord::Base
  def self.find_or_create(args)
    descr = args[:descr]
    fecha = args[:fecha]
    return find_by_fecha(fecha) || create(:descr => nil, :fecha => fecha) if (fecha && !descr) 
    return find_by_descr(descr) || create(:descr => descr, :fecha => Time.now.strftime("%d-%m-%Y")) if (!fecha && descr)
    return first(:conditions => ["descr = ? AND fecha = ?",descr,fecha]) || create(:descr => descr, :fecha => fecha) if (fecha && descr)
  end
end
