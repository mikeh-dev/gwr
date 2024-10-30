class AgreementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_agreement, only: [:show, :edit, :update, :destroy]
  after_action :verify_policy_scoped, only: :index
  before_action :set_tenants_and_properties, only: [:new, :edit, :create, :update]
  

  def index
    @agreements = policy_scope(Agreement)
    @current_agreements = Agreement.where("end_date >= ? AND (landlord_id = ? OR tenant_id = ?)", Date.today, current_user.id, current_user.id)
    @upcoming_renewals = @current_agreements.select { |agreement| agreement.renewal_date <= Date.today + 90 }
    @expired_agreements = Agreement.where("end_date < ? AND (landlord_id = ? OR tenant_id = ?)", Date.today, current_user.id, current_user.id)
  end

  def show
    authorize @agreement
  end

  def new
    @agreement = Agreement.new
    authorize @agreement
  end

  def create
    @agreement = Agreement.new(agreement_params.except(:landlord_id))
    property = Property.find(params[:agreement][:property_id])
    @agreement.landlord = property.landlord
    authorize @agreement
  
    if @agreement.save
      redirect_to @agreement, notice: 'Agreement was successfully created.'
    else
      Rails.logger.debug("Agreement errors: #{@agreement.errors.full_messages}")
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @agreement

    @agreement = Agreement.find(params[:id])

    if @agreement.update(agreement_params.except(:landlord_id))
      property = Property.find(params[:agreement][:property_id])
      @agreement.update(landlord: property.landlord)

      redirect_to @agreement, notice: 'Agreement was successfully updated.'
    else
      Rails.logger.debug("Agreement errors: #{@agreement.errors.full_messages}")
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    authorize @agreement
  end


  def destroy
    authorize @agreement
    @agreement.destroy
    redirect_to agreements_url, notice: 'Agreement was successfully deleted.'
  end

  def remove_image
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge_later
    redirect_back(fallback_location: request.referer, notice: 'Image was successfully removed.')
    
  end

  private

  def set_agreement
    @agreement = Agreement.find(params[:id])
    @property = @agreement.property
  end

  def set_tenants_and_properties
    @tenants = User.where(role: 'tenant')
    @properties = current_user.admin? ? Property.all : current_user.properties
  end

  def agreement_params
    params.require(:agreement).permit(:property_id, :tenant_id, :length, :monthly_rent_amount, :start_date, :end_date, :notice_period, :agreement_number, :status, :price, move_in_images: [])
  end
end