require 'rails_helper'

RSpec.describe "Navbar", type: :system do
  context "when user is logged out" do
    it "displays the correct navbar links" do
      visit root_path

      expect(page).to have_link("Sign in", href: new_user_session_path)
      expect(page).to have_link("Sign up", href: new_user_registration_path)
    end
  end

  context "when user is logged in" do
    let(:user) { create(:user) } # Assuming you're using FactoryBot for fixtures

    before do
      login_as(user, scope: :user)
    end

    it "displays the correct navbar links" do
      visit root_path

      expect(page).not_to have_link("Sign in")
      expect(page).not_to have_link("Sign up")
    end
  end
end
