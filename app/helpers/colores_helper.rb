module ColoresHelper
  def path
    params[:action] == "index" ? colores_path() : colore_path(@attribute)
  end
end
