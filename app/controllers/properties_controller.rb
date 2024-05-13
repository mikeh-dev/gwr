class PropertiesController < ApplicationController

  def index
    @properties = Property.all
  end

  def show
    @property = Property.find(params[:id])
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    @property.owner_id = current_user.id
    if @property.save
      redirect_to @property, notice: 'Property was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    redirect_to properties_path
  end

  private

  def property_params
    params.require(:property).permit(:title, :address, :postcode, :city, :property_type, :owner_id)
  end

end
