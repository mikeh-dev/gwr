require 'rails_helper'

RSpec.describe "Dashbaord", type: :system do
  let(:user) { create(:user, role: :landlord) }

  before do
    login_as user
  end

  it 'allows landlord user to view the dashboard' do
    visit root_path
    expect(page).to have_content('Dashboard', count: 2)
    within('#hero') do
      click_link 'Dashboard'
    end
    expect(page).to have_content("Here is what's happening today")
  end

  it 'allows landlord user to view the properties' do
    visit admin_dashboard_path
    expect(page).to have_content('Properties', count: 3)
    within('#properties-pill') do
      click_link 'Properties'
    end
    expect(page).to have_content('Properties')
    expect(page).to have_content('Create property')
    visit admin_dashboard_path
    within('#dashboard-boxed-links') do
      click_link 'Properties'
    end
    expect(page).to have_content('Properties')
    expect(page).to have_content('Create property')
  end


end