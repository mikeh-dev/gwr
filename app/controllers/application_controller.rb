class ApplicationController < ActionController::Base
  helper Railsui::ThemeHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :first_name, :last_name, :name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :first_name, :last_name, :name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end

  include Pundit::Authorization
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to access this page."
    redirect_to(request.referrer || root_path)
  end

  def load_properties_and_agreements
    if current_user.admin?
      @properties = Property.all
      @agreements = Agreement.all
    else
      @agreements_as_landlord = current_user.agreements_as_landlord.exists? ? current_user.agreements_as_landlord : []
      @agreements_as_tenant = current_user.agreements_as_tenant.exists? ? current_user.agreements_as_tenant : []
      @agreements = @agreements_as_landlord + @agreements_as_tenant

      @current_agreements = Agreement.where("end_date >= ? AND (landlord_id = ? OR tenant_id = ?)", Date.today, current_user.id, current_user.id)
      @upcoming_renewals = @current_agreements.select { |agreement| agreement.renewal_date <= Date.today + 90 }
      @expired_agreements = Agreement.where("end_date < ? AND (landlord_id = ? OR tenant_id = ?)", Date.today, current_user.id, current_user.id)

      owned_property_ids = Property.where(owner_id: current_user.id).pluck(:id)
      tenant_property_ids = Agreement.where(tenant_id: current_user.id)
                                     .where('start_date <= ? AND end_date >= ?', Date.today, Date.today)
                                     .pluck(:property_id).uniq

      @properties = Property.where(id: (owned_property_ids + tenant_property_ids).uniq).includes(:agreements)
    end
  end
end