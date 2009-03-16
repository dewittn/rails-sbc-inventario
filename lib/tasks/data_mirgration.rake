namespace :data do
  
  desc "Creates Facturas using date"
  task(:create_factura => :environment) do
    puts "Creating Facturas using date"
    Inventario.all.each do |inventario|
      unless inventario.factura_id
        inventario.fecha = inventario.created_at.strftime("%d-%m-%Y")
        inventario.find_or_create_factura
        puts "Factura created for #{inventario.id}" if inventario.save
      end
    end
  end
  
  desc "Creates Historia"
  task(:create_historia => :environment) do
    puts "Creating Facturas using date"
    Inventario.all.each do |inventario|
      unless inventario.historia
        puts "created history for #{inventario.id}" if inventario.create_history
      end
    end
  end
  
  task(:fill_missing_data => :environment)do
    Inventario.all.each do |inventario|
      inventario.update_attributes(:estilo_id => 1, :genero_id => 1)
    end
  end
end