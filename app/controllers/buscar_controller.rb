class BuscarController < ApplicationController
  def index
    redirect_to(buscar_index_path)  if params[:commit] == "Limpiar"
    @sql ||= build_sql(Color,Marca,Genero,Estilo,Tipo,Talla,:codigo_id)
    html_xml_search
  end
end
