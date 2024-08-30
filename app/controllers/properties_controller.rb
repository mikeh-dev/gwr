class PropertiesController < ApplicationController
  before_action :authenticate_user!
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
    @property = Property.find(params[:id])

    # Manage the images
    if params[:property][:property_image_ids].present?
      image_ids_to_keep = params[:property][:property_image_ids].map(&:to_i)
      images_to_remove = @property.property_images.where.not(id: image_ids_to_keep)
      images_to_remove.each(&:purge)
    end

    # Remove the property_image_ids param from the update process
    params[:property].delete(:property_image_ids)

    if @property.update(property_params)
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @property.destroy
    redirect_to properties_path, notice: 'Property was successfully deleted.'
  end

  private
  
  def property_params
    params.require(:property).permit(:title, :address, :postcode, :city, :property_type, :owner_id, :notes, tenant_ids: [], property_images: [])
  end

  def set_property
    @property = Property.find(params[:id])
  end

  def remove_image
    @property = Property.find(params[:id])
    image = @property.property_images.find(params[:image_id])
    image.purge # ActiveStorage method to delete the attachment

    respond_to do |format|
      format.html { redirect_to edit_property_path(@property), notice: 'Image removed successfully.' }
      format.turbo_stream # This line ensures Turbo Stream response is handled
    end
  end

end