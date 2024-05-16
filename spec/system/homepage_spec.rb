require 'rails_helper'

RSpec.describe "Homepage", type: :system do
  let(:user) { create(:user) }

  context "when user is signed in" do
    before do
      login_as user
      visit root_path
    end

    it "displays the navigation bar with links" do
      expect(page).to have_selector('nav')
      expect(page).to have_link("Dashboard", href: admin_dashboard_path)
      expect(page).to have_link("Get Started", href: "#")
    end

    it "displays the hero section with title and description" do
      expect(page).to have_selector('h1', text: /We leverage technology to protect/i)
      expect(page).to have_selector('p', text: /With Renting sometimes things can go wrong/i)
    end

    it "displays the user avatar" do
      if user.avatar.attached?
        expect(page).to have_selector("img[src*='#{user.avatar.filename}']")
      end
    end
  end

  context "when user is not signed in" do
    before do
      visit root_path
    end

    it "displays the hero section with title and description" do
      expect(page).to have_selector('h1', text: /We leverage technology to protect/i)
      expect(page).to have_selector('p', text: /With Renting sometimes things can go wrong/i)
    end

    it "displays the primary call-to-action buttons" do
      expect(page).to have_link("Learn more", href: "#")
      expect(page).to have_link("Sign Up Now", href: new_user_registration_path)
    end
  end

  it "displays the co-founder images and descriptions" do
    visit root_path

    expect(page).to have_selector("p", text: "Mitch Erskine")
    expect(page).to have_selector("p", text: "Co-founder")
  end

  it "displays the statistics section" do
    visit root_path

    expect(page).to have_selector('h4', text: "98%")
    expect(page).to have_selector('p', text: "Uptime")
    expect(page).to have_selector('h4', text: "94.7%")
    expect(page).to have_selector('p', text: "Accuracy")
    expect(page).to have_selector('h4', text: "9%")
    expect(page).to have_selector('p', text: "Returns*")
  end

  it "displays the team section with images and roles" do
    visit root_path
    expect(page).to have_selector("img")
    expect(page).to have_selector("h4", text: "Jake Jones")
    expect(page).to have_selector("p", text: "Co-founder")

    expect(page).to have_selector("img")
    expect(page).to have_selector("h4", text: "Jackie Jones")
    expect(page).to have_selector("p", text: "Co-founder")



    expect(page).to have_selector("h4", text: "Ryan Coover")
    expect(page).to have_selector("p", text: "Product Lead")

  end

  it "displays the newsletter section" do
    visit root_path

    expect(page).to have_selector('h3', text: "Want to read more about what")
    
  end

  it "displays the footer" do
    visit root_path

    expect(page).to have_selector('footer')
  end
end
