class PropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_landlord!, only: [:new, :create, :edit, :update]
  before_action :check_owner, only: [:edit, :update, :destroy, :show]
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  def index
    @properties = policy_scope(Property)
    authorize Property
  end
  
  def show
    authorize @property
  end

  def new
    @property = Property.new
    authorize @property
  end

  def create
    @property = Property.new(property_params)
    @property.owner_id = current_user.id
    authorize @property
    if @property.save
      redirect_to @property, notice: 'Property was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @property.update(property_params)
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    redirect_to properties_path, notice: 'Property was successfully deleted.'
  end

  private

  def authorize_landlord!
    unless current_user.landlord? || current_user.admin?
      redirect_to root_path, notice: 'You are not authorized to access this page.'
    end 
  end

  def check_owner
    @property = Property.find(params[:id])
    unless current_user.admin? || @property.owner_id == current_user.id || @property.agreements.where(tenant_id: current_user.id).exists?
      redirect_to root_path, notice: 'You are not authorized to access this page.'
    end
  end

  def property_params
    params.require(:property).permit(:title, :address, :postcode, :city, :property_type, :owner_id, :notes, tenant_ids: [])
  end

  def set_property
    @property = Property.find(params[:id])
  end

  def authorize_property
    authorize @property
  end
end