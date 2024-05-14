# spec/features/user_signup_spec.rb
require 'rails_helper'

RSpec.feature "User Signup", type: :feature do
  scenario "User signs up with valid credentials" do
    visit new_user_registration_path
    
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    click_button "Sign up"
    
    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(User.last.email).to eq("test@example.com")
  end

  scenario "User signs up with invalid credentials" do
    visit new_user_registration_path
    
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "wrongpassword"
    click_button "Sign up"
    
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end