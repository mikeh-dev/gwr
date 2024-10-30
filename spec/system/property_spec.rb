require 'rails_helper'

RSpec.describe 'Property CRUD', type: :system do
  let!(:landlord) { create(:user, :landlord) }
  let!(:landlord2) { create(:user, :landlord) }
  let!(:admin) { create(:user, :admin) }
  let!(:tenant) { create(:user, :tenant) }
  let!(:property) { create(:property, landlord: landlord) }
  let!(:property2) { create(:property, landlord: landlord2) }
  let!(:agreement) { create(:agreement, :current, tenant: tenant, property: property) }

  context 'when not logged in' do
    it 'does not allow access to new property page' do
      visit new_property_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it 'does not allow access to edit property page' do
      visit edit_property_path(property)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it 'does not allow access to the property listings page' do
      visit properties_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end

  context 'when logged in as admin' do

    before do
      login_as admin
    end

    it 'allows admin user to delete a property' do
      visit property_path(property)
      click_link 'Delete Property'
      expect(page).to have_content('Property was successfully deleted.')
    end

    it 'allows an admin user to create a property' do
      visit new_property_path
      expect(page).to have_content('New Property')
      fill_in 'Title', with: 'New Property'
      fill_in 'First Line of Address', with: '123 Main Street'
      fill_in 'Town/City', with: 'Sample City'
      fill_in 'Postcode', with: '12345'
      select 'House', from: 'Property type'
      click_button 'Save Property'
      expect(page).to have_content('Property was successfully created.')
    end

    it 'allows an admin user to edit a property' do
      visit edit_property_path(property)
      expect(page).to have_content('Edit Property')
      fill_in 'Title', with: 'Updated Title'
      click_on 'Save Property'
      expect(page).to have_content('Property was successfully updated.')
    end

    it 'allows an admin user to view any property' do
      visit property_path(property)
      expect(page).to have_content('Property Details')
    end
  end

  context 'when logged in as landlord' do
    before do
      login_as landlord
    end

    it 'allows landlord user to create a property' do
      visit new_property_path
      expect(page).to have_content('New Property')
      fill_in 'Title', with: 'New Property'
      fill_in 'First Line of Address', with: '123 Main Street'
      fill_in 'Town/City', with: 'Sample City'
      fill_in 'Postcode', with: '12345'
      select 'House', from: 'Property type'
      click_button 'Save Property'
      expect(page).to have_content('Property was successfully created.')
    end

    it 'allows landlord user to edit a property' do
      visit property_path(property)

      click_link 'Edit Property'

      fill_in 'Title', with: 'Updated Title'
      click_on 'Save Property'

      expect(page).to have_content('Property was successfully updated.')
    end

    it 'does not allow landlord user to delete a property' do
      visit property_path(property)
      click_link 'Edit Property'
      expect(page).to have_content('Edit Property')
      expect(page).not_to have_link('Delete Property')
    end
  end

  context 'when logged in as tenant' do
    before do
      login_as tenant
    end

    it 'does not allow tenant user to create a property' do
      visit new_property_path
      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'does not allow tenant user to edit a property' do
      visit edit_property_path(property)
      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'does not allow tenant user to delete a property' do
      visit property_path(property)
      expect(page).not_to have_link('Delete Property')
    end

    it 'does not allow tenant user to view the property listings page' do
      visit properties_path
      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'allows a tenant user to view a property which it is the current tenant of' do
      visit property_path(property)
      expect(page).to have_content(property.title)
    end

    it 'does not allow a tenant user to view a property which it is not the current tenant of' do
      visit property_path(property2)
      expect(page).not_to have_content(property2.title)
    end
  end
end