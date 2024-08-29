class PageController < ApplicationController
	before_action :authenticate_user!, only: [:dashboard]


	def home
	end

	def account_preferences
		render layout: 'admin'
	end

	def account_notifications
		render layout: 'admin'
	end

	def account_payouts
		render layout: 'admin'
	end

	def account_payment_methods
		render layout: 'admin'
	end

	def contact
		render layout: 'admin'
	end

	def terms
		render layout: 'admin'
	end

	def privacy_policy
		render layout: 'admin'
	end

	def api
		render layout: 'admin'
	end

	def changelog
		render layout: 'admin'
	end

	def help_center
		render layout: 'admin'
	end

	def edit_booking
		render layout: 'admin'
	end

	def booking
		render layout: 'admin'
	end

	def new_booking
		render layout: 'admin'
	end

	def bookings
		render layout: 'admin'
	end

	def insights
		render layout: 'admin'
	end

	def calendar
		render layout: 'admin'
	end

	def inbox
		render layout: 'admin'
	end

	def properties
		render layout: 'admin'
	end

	def dashboard
		if current_user.admin?
			@users = User.all.not_admin
			@landlords = User.where(role: 'landlord')
			@tenants = User.where(role: 'tenant')
			@properties = Property.all
	
			@agreements = Agreement.all
		else
			@agreements = Agreement.where("landlord_id = ? OR tenant_id = ?", current_user.id, current_user.id)
	
			owned_properties = Property.where(owner_id: current_user.id)
			tenant_property_ids = @agreements.pluck(:property_id).uniq
			@properties = Property.where(id: owned_properties.pluck(:id) + tenant_property_ids).includes(:agreements).distinct
		end
	
		@current_agreements = @agreements.where("end_date >= ?", Date.today)
		@upcoming_renewals = @current_agreements.select { |agreement| agreement.renewal_date <= Date.today + 90 }
		@expired_agreements = @agreements.where("end_date < ?", Date.today)
	end
	

	def pricing
	end

	def about
	end
end
