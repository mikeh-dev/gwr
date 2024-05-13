require 'rails_helper'

RSpec.describe "Homepage", type: :system do
  context "when user is logged out" do
    it "displays the correct homepage content" do
      visit root_path
      expect(page).to have_content("With Renting sometimes things can go wrong")
      expect(page).to have_link("Sign in", visible: :all)
      expect(page).to have_link("Sign Up Now")
    end
  end

  context "when user is logged in" do
  end
end