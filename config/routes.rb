Rails.application.routes.draw do
	get 'admin/account_preferences', to: 'page#account_preferences'
	get 'admin/account_notifications', to: 'page#account_notifications'
	get 'admin/account_payouts', to: 'page#account_payouts'
	get 'admin/account_payment_methods', to: 'page#account_payment_methods'
	get 'admin/contact', to: 'page#contact'
	get 'admin/terms', to: 'page#terms'
	get 'admin/privacy_policy', to: 'page#privacy_policy'
	get 'admin/api', to: 'page#api'
	get 'admin/changelog', to: 'page#changelog'
	get 'admin/help_center', to: 'page#help_center'
	get 'admin/edit_booking', to: 'page#edit_booking'
	get 'admin/booking', to: 'page#booking'
	get 'admin/new_booking', to: 'page#new_booking'
	get 'admin/bookings', to: 'page#bookings'
	get 'admin/insights', to: 'page#insights'
	get 'admin/calendar', to: 'page#calendar'
	get 'admin/inbox', to: 'page#inbox'
	get 'admin/properties', to: 'page#properties'
	get 'admin/dashboard', to: 'page#dashboard'
	get 'pricing', to: 'page#pricing'
	get 'about', to: 'page#about'
  if Rails.env.development? || Rails.env.test?
    mount Railsui::Engine, at: "/railsui"
  end

  # Inherits from Railsui::PageController#index
  # To overide, add your own page#index view or change to a new root
  # Visit the start page for Rails UI any time at /railsui/start
  root action: :index, controller: "railsui/page"

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
