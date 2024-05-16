class PropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_landlord!, only: [:new, :create, :edit, :update, :destroy]

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
    redirect_to properties_path, notice: 'Property was successfully deleted.'
  end

  private

  def authorize_landlord!
    unless current_user.landlord? || current_user.role == 'admin'
      redirect_to properties_path, alert: 'You are not authorised to access this page.'
    end
  end

  def property_params
    params.require(:property).permit(:title, :address, :postcode, :city, :property_type, :owner_id, :notes)
  end

end
