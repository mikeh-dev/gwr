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
			@properties = Property.all
			@agreements = Agreement.all
			@properties = Property.all
		else
			@agreements_as_landlord = current_user.agreements_as_landlord.exists? ? current_user.agreements_as_landlord : []
			@agreements_as_tenant = current_user.agreements_as_tenant.exists? ? current_user.agreements_as_tenant : []
			@agreements = @agreements_as_landlord + @agreements_as_tenant
			owned_properties = Property.where(owner_id: current_user.id)
			tenant_property_ids = Agreement.where(tenant_id: current_user.id).pluck(:property_id).uniq
			tenant_properties = Property.where(id: tenant_property_ids)
			@properties = Property.where(id: owned_properties.pluck(:id) + tenant_property_ids).includes(:agreements).distinct
		end
		
		render layout: 'admin'
	end

	def pricing
	end

	def about
	end
end
