class AgreementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_agreement, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  before_action :set_tenants_and_properties, only: [:new, :edit, :create, :update]
  

  def index
    @agreements = policy_scope(Agreement)
    @current_agreements = Agreement.where("end_date >= ? AND (landlord_id = ? OR tenant_id = ?)", Date.today, current_user.id, current_user.id)
    @upcoming_renewals = @current_agreements.select { |agreement| agreement.renewal_date <= Date.today }
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
    @agreement = Agreement.new(agreement_params)
    authorize @agreement
    property = Property.find(params[:agreement][:property_id])
    @agreement.landlord = property.landlord

    Rails.logger.debug("Landlord set to: #{@agreement.landlord.full_name} (Role: #{@agreement.landlord.role})")
    Rails.logger.debug("Agreement details: #{@agreement.inspect}")


    if @agreement.save
      redirect_to @agreement, notice: 'Agreement was successfully created.'
    else
      Rails.logger.debug("Agreement errors: #{@agreement.errors.full_messages}")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @agreement
  end

  def update
    authorize @agreement
    if @agreement.update(agreement_params)
      redirect_to @agreement, notice: 'Agreement was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @agreement
    @agreement.destroy
    redirect_to agreements_url, notice: 'Agreement was successfully deleted.'
  end

  private

  def set_agreement
    @agreement = Agreement.find(params[:id])
  end

  def set_tenants_and_properties
    @tenants = User.where(role: 'tenant')
    @properties = current_user.admin? ? Property.all : current_user.properties
  end

  def agreement_params
    params.require(:agreement).permit(:length, :start_date, :end_date, :notice_period, :monthly_rent_amount, :property_id, :landlord_id, :tenant_id, :agreement_number)
  end
end