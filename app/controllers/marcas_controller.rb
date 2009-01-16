class MarcasController < ApplicationController
  before_filter :login_required
  
  def index
    @attributes = model.all
    @attribute = model.new
  end
  
  def edit
    @attributes = model.all
    @attribute = model.find(params[:id])
    render :action => "index"
  end
  
  def update
    @attribute = model.find(params[:id])
    if @attribute.update_attribute(:descr, params[:marca][:descr])
      flash[:notice] = "#{model.name} updated..."  
      redirect_to :action => "index"
    else
      @attributes = model.all
      render :action => :index
    end
  end
  
  def create
    @attribute = model.new(params[:marca])
    if @attribute.save
      flash[:notice] = "#{model.name} created..."  
      redirect_to :action => "index"
    else
      @attributes = model.all
      render :action => :index
    end
  end
  
  def destroy
    model.destroy(params[:id])
    redirect_to :action => "index"
  end
  
  def model
    @model ||= Marca
  end
  
end
