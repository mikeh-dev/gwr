require 'rails_helper'

RSpec.describe "Landlord Property CRUD", type: :system do
  let(:user) { create(:user, role: :landlord) }

  before do
    login_as user
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
    fill_in 'Property type', with: 'House'
    click_button 'Save Property'
    expect(page).to have_content('Property was successfully created.')
  end

end