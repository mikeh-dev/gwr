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
			@users = User.not_admin
			@landlords = User.landlords
			@tenants = User.tenants
			@properties = Property.all
			@agreements = Agreement.all
			@repair_cases = RepairCase.all
		elsif current_user.landlord?
			@properties = current_user.properties
			@agreements = current_user.agreements_as_landlord
		else
			@agreements = current_user.agreements_as_tenant
			@property = @agreements.current.first&.property
		end
	
		@current_agreements = @agreements.current
		@upcoming_renewals = @agreements.upcoming_renewals
		@expired_agreements = @agreements.expired
	end
	
	def pricing
	end

	def about
	end
end