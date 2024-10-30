class PropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  def index
    @properties = policy_scope(Property)
    authorize Property
  end
  
  def show
    authorize @property
  rescue Pundit::NotAuthorizedError
    redirect_to root_path, alert: 'You are not authorized to access this page.'
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
    authorize @property
  end

  def update
    if @property.update(property_params)
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def remove_image
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge_later
    redirect_back(fallback_location: request.referer, notice: 'Image was successfully removed.')
  end

  private
  
  def property_params
    params.require(:property).permit(:title, :address, :postcode, :city, :property_type, :owner_id, :notes, tenant_ids: [], property_images: [])
  end  

  def set_property
    @property = Property.find(params[:id])
  end

end