class ColoresController < ApplicationController
  # cache_sweeper is deprecated in Rails 4.2 - TODO: replace with cache expiration
  # cache_sweeper :color_sweeper, :only => [:update, :create, :destory]
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
    if @attribute.update(color_params)
      flash[:notice] = "#{model.name} updated..."
      redirect_to action: "index"
    else
      @attributes = model.all
      render action: :index
    end
  end

  def create
    @attribute = model.new(color_params)
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
    @model ||= Color
  end

  def color_params
    params.require(:color).permit(:descr)
  end
end
