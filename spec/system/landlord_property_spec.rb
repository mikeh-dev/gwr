require 'rails_helper'

RSpec.describe "Landlord Property CRUD", type: :system do
  let(:landlord) { create(:user, role: :landlord) }
  let(:tenant) { create(:user, role: :tenant) }
  let!(:property) { create(:property, owner_id: landlord.id) }

  context 'as a landlord user' do
    before do
      login_as landlord
    end
  
    it 'allows landlord user to create a property' do
      visit admin_dashboard_path
      expect(page).to have_content('Properties', count: 3)
      within('#properties-pill') do
        click_link 'Properties'
      end
      expect(page).to have_content('Properties')
      expect(page).to have_content('Create property')
      click_link 'Create property'
      expect(page).to have_content('New Property')
      fill_in 'Title', with: 'My new property'
      fill_in 'Address', with: '123 Main St'
      fill_in 'Postcode', with: '12345'
      fill_in 'City', with: 'Anytown'
      select 'House', from: 'Property type'
      click_button 'Save Property'
      expect(page).to have_content('Property was successfully created.')
    end
  
    it 'allows landlord user to edit a property' do
      visit admin_dashboard_path
      within('#properties-pill') do
        click_link 'Properties'
      end
      expect(page).to have_content('Properties')
      expect(page).to have_content(property.title)
      find('button#property-dropdown-menu').click
      click_link 'Edit property'
      expect(page).to have_content('Edit Property')
      fill_in 'Title', with: 'My updated property'
      click_button 'Save Property'
      expect(page).to have_content('Property was successfully updated.')
    end
  
    it 'allows landlord user to delete a property' do
      visit admin_dashboard_path
      within('#properties-pill') do
        click_link 'Properties'
      end
      expect(page).to have_content('Properties')
      expect(page).to have_content(property.title)
      find('button#property-dropdown-menu').click
      click_link 'Edit property'
      expect(page).to have_content('Edit Property')
      accept_confirm do
        click_on 'Delete Property'
      end
      expect(page).to have_content('Property was successfully deleted.')
    end
  
    it 'allows landlord user to view a property' do
      visit admin_dashboard_path
      within('#properties-pill') do
        click_link 'Properties'
      end
      expect(page).to have_content('Properties')
      expect(page).to have_content(property.title)
      click_link property.title
      expect(page).to have_content(property.title)
    end
  end

  context 'as a tenant user' do
    before do
      login_as tenant
    end

    it 'does not allow tenant user to create a property' do
      visit properties_path
      expect(page).not_to have_content('Create property')
      visit new_property_path
      expect(page).to have_content('You are not authorised to access this page.')
    end

    it 'does not allow tenant user to edit a property' do
      visit properties_path
      find('button#property-dropdown-menu').click
      expect(page).not_to have_content('Edit property')
      visit edit_property_path(property)
      expect(page).to have_content('You are not authorised to access this page.')
    end

    it 'does not allow tenant user to delete a property' do
      visit admin_dashboard_path
      expect(page).to have_content('You are not authorised to access this page.')
      visit property_path(property)
      expect(page).not have_content('Delete Property')
    end
  end
end