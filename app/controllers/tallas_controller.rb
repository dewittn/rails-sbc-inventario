class TallasController < ApplicationController
  # cache_sweeper is deprecated in Rails 4.2 - TODO: replace with cache expiration
  before_action :login_required

  def index
    @attributes = model.all
    @attribute = model.new
  end

  def edit
    @attributes = model.all
    @attribute = model.find(params[:id])
    render action: "index"
  end

  def update
    @attribute = model.find(params[:id])
    if @attribute.update(talla_params)
      flash[:notice] = "#{model.name} updated..."
      redirect_to action: "index"
    else
      @attributes = model.all
      render action: :index
    end
  end

  def create
    @attribute = model.new(talla_params)
    if @attribute.save
      flash[:notice] = "#{model.name} created..."
      redirect_to action: "index"
    else
      @attributes = model.all
      render action: :index
    end
  end

  def destroy
    model.destroy(params[:id])
    redirect_to action: "index"
  end

  private

  def model
    @model ||= Talla
  end

  def talla_params
    params.require(:talla).permit(:descr)
  end
end
