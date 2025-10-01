class MarcasController < ApplicationController
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
    if @attribute.update(marca_params)
      flash[:notice] = "#{model.name} updated..."
      redirect_to action: "index"
    else
      @attributes = model.all
      render action: :index
    end
  end

  def create
    @attribute = model.new(marca_params)
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
    @model ||= Marca
  end

  def marca_params
    params.require(:marca).permit(:descr)
  end
end
