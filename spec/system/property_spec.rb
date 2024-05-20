require 'rails_helper'

RSpec.describe 'Property CRUD', type: :system do
  let!(:landlord) { create(:user, :landlord) }
  let!(:property) { create(:property, landlord: landlord, title: 'Old Title') }

  before do
    login_as landlord
  end

  it 'allows landlord user to create a property', js: true do
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

  it 'allows landlord user to edit a property', js: true do
    visit property_path(property)

    click_link 'Edit Property'

    fill_in 'Title', with: 'Updated Title'
    click_on 'Save Property'

    expect(page).to have_content('Property was successfully updated.')
  end

  it 'allows landlord user to delete a property', js: true do
    visit property_path(property)
    click_link 'Edit Property'
    expect(page).to have_content('Edit Property')

    accept_confirm do
      click_on 'Delete Property'
    end

    expect(page).to have_content('Property was successfully deleted.')
  end
end
