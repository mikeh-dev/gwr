# GWR - GoodWillRenting
MVP Proof of Concept - Rental Management System for Landlords and Tenants

### Introduction
GWR is a rental management system for landlords and tenants. It enables landlords and tenants to manage their rental properties and agreements. The initial idea was from a friend and was something I worked on in my spare time.

The basic outline was to create a platform where a landlord could create a property record and an agreement record which would be linked to a tenant. The tenant would then be able to login and see the details of the agreement and the property. Once of the core features was to be the ability to upload 'moving in images' which would be used to verify the condition of the property at the start of the tenancy.

The secondary feature was to enable the tenant to report issues with the property and to enable the landlord to manage these issues. Both the tenant and landlord would have a dashboard to enable them to manage the tenancy, view cases and messages.

### Current Status

Unfinished - 31/10/24

The project is currently in the very early stages of development and is not yet functional. The basic User authentication, property and agreement functionality is there but the case reporting is not yet implemented.

There is a basic dashboard for Admin, Landlord and Tenant users. There is basic view pages for agreements and properties.

Users can upload images for the property and for the agreements.

Pundit is used for authorization utilising the roles of Admin, Landlord and Tenant.

### Technologies used:
- Rails 7 with Hotwire
- Ruby 3.1
- PostgreSQL
- TailwindCSS
- Devise for authentication
- Pundit for authorization
- Rspec with FactoryBot, ShouldaMatchers, Capybara, Faker for testing
- Mapbox for the map functionality

 # Acknowledgements
Once again UI was given a lift with Rails UI from Andy Leverenz. More info on that here: https://github.com/andyleverenz/rails_ui