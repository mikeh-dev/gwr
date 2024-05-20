require 'rails_helper'

RSpec.feature "Navigation", type: :feature do
  let(:user) { create(:user) }

  context "when user is signed in" do
    before do
      login_as user
      visit root_path
    end

    it "displays the admin dashboard link with the SVG logo" do
      expect(page).to have_link(href: admin_dashboard_path) do |link|
        expect(link).to have_selector("svg.text-zinc-900.fill-current.w-10.h-10")
        expect(link).to have_selector("span.sr-only", text: "GoodWillRenting")
      end
    end

    it "displays the mobile navigation button" do
      expect(page).to have_selector('button[data-action="click->nav#toggle"]')
    end

    it "displays the user avatar" do
      if user.avatar.attached?
        expect(page).to have_selector("img[src*='#{user.avatar.filename}']")
      end
    end

    it "displays the dropdown menu with links" do
      expect(page).to have_button("dropdown-menu", exact: true)
    
      expect(page).to have_link("Inbox", href: admin_inbox_path)
      expect(page).to have_link("Manage properties", href: properties_path)
      expect(page).to have_link("Add booking", href: admin_new_booking_path)
      expect(page).to have_link("Account", href: edit_user_registration_path)
      expect(page).to have_button("Sign out", exact: true)
    end
  end

  context "when user is not signed in" do
    before do
      visit root_path
    end

    it "displays the root path link with the SVG logo" do
      expect(page).to have_link(href: root_path) do |link|
        expect(link).to have_selector("svg.text-zinc-900.fill-current.w-10.h-10")
      end
    end

    it "displays sign in and sign up links" do
      expect(page).to have_link("Sign in", href: new_user_session_path)
      expect(page).to have_link("Get started", href: new_user_registration_path)
    end

    it "displays primary navigation links" do
      expect(page).to have_link("Features", href: "#")
      expect(page).to have_link("Pricing", href: "#")
      expect(page).to have_link("About", href: "#")
    end
  end
end
