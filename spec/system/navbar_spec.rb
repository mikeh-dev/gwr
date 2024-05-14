require 'rails_helper'

RSpec.describe "Navbar", type: :system do

  before do
    page.driver.browser.manage.window.resize_to(1280, 1024)  # Set to desktop size
  end  
  
  scenario "when user is logged out" do
    visit root_path
    expect(page).to have_link("Sign in", href: new_user_session_path)
    expect(page).to have_link("Get started", href: new_user_registration_path)
    expect(page).to have_link("Sign Up Now", href: new_user_registration_path)
    expect(page).to have_content(svg_icon("logo", href: root_path))
  end

  let(:user) { create(:user) }  # Ensure you have a user factory

  scenario "when user is signed in" do
    login_as(user, scope: :user)
    visit root_path

    expect(page).to have_link("Inbox", href: admin_inbox_path)
    expect(page).to have_button("Sign out", visible: :all)
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Get started")
    expect(page).not_to have_link("Sign Up Now")
    expect(page).to have_link("Profile", href: user_path(user))
    expect(page).to have_content("logo", href: root_path)
  end
end