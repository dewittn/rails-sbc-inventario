namespace :insert do
  desc "Agrega todos los valores de Marca, Tipo, Color y Talla a la base de datos"
  task(:Colors => :environment) do
    puts "inserting Colores"
    new_record(Color,'Rojo')
    new_record(Color,'Azul')
    new_record(Color,'Verde')
    new_record(Color,'Amarillo')
    new_record(Color,'Rosado')
    new_record(Color,'Blanco')
    new_record(Color,'Negro')
    new_record(Color,'Navy')
    new_record(Color,'Celeste')
    new_record(Color,'Khaki')
    new_record(Color,'Gris')
    new_record(Color,'Verde Claro')
    new_record(Color,'Rojo Vino')
    new_record(Color,'Turqueza')
    new_record(Color,'Aqua')
    new_record(Color,'Amarillo Claro')
    new_record(Color,'Verde Aqua')
    new_record(Color,'Anarajado')
    new_record(Color,'Verde Oscuro')
    new_record(Color,'Mamey')
    new_record(Color,'Lila')
    new_record(Color,'Fucsia')
    puts "done"
  end


  task(:Marcas => :environment) do
    puts "inserting Marcas"
    new_record(Marca,'Unicrese')
    new_record(Marca,'Jonny')
    new_record(Marca,'America JR')
    new_record(Marca,'Canal Club')
    new_record(Marca,'America Lady')
    new_record(Marca,'Canal Club Ladies') 
    puts "done"   
  end
  
  task(:Tallas => :environment) do
    puts "inserting Tallas"
    new_record(Talla,'04')
    new_record(Talla,'06')
    new_record(Talla,'08')
    new_record(Talla,'10')
    new_record(Talla,'12')
    new_record(Talla,'16')
    new_record(Talla,'18')
    new_record(Talla,'20')
    new_record(Talla,'S')
    new_record(Talla,'M')
    new_record(Talla,'L')
    new_record(Talla,'XL')
    new_record(Talla,'XXL')
    new_record(Talla,'XXXL')
    puts "done"
  end
  
  task(:Tipos => :environment) do
    puts "inserting Tipos"
    new_record(Tipo,'Polo')
    new_record(Tipo,'Redondo')
    new_record(Tipo,'Gorras')      
  end
  
  task(:Generos => :environment) do
    puts "inserting Generos"
    new_record(Genero,'Humbre')
    new_record(Genero,'Mujer')
    new_record(Genero,'Niño')
    puts "done"      
  end
  
  task(:Estilos => :environment) do
    puts "inserting Estilos"
    new_record(Estilo,'Normal')
    new_record(Estilo,'Rayas')
    new_record(Estilo,'Malla')
    puts "done"      
  end
  
  task(:import_ubicacion => :environment) do
    puts "importing ubicacion"
    Inventario.all.each do |inventario|
      inventario.find_or_create__ubcicion
    end
  end
  
  task :all => [:Colors,:Marcas,:Tallas,:Tipos,:Generos]
  
  
  
  def new_record(model,text)
    x = model.new(:descr => text)
    x.save!
  end

end