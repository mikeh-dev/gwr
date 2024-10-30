require 'rails_helper'

RSpec.feature "User Signup", type: :feature do
  scenario "User signs up with valid credentials" do
    visit new_user_registration_path
    fill_in "First name", with: "Test"
    fill_in "Last name", with: "User"
    fill_in "Email", with: "test@example.com"
    expect(page).to have_select('user_role', with_options: ['Choose an account type'] + User.roles.except("admin").keys.map(&:titleize))
    select 'Landlord', from: 'user_role'
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    click_button "Sign up"
    
    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(User.last.email).to eq("test@example.com")
  end

  scenario "User signs up with invalid credentials" do
    visit new_user_registration_path
    fill_in "First name", with: "Test"
    fill_in "Last name", with: "User"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "wrongpassword"
    click_button "Sign up"
    
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario "User attempts to sign up with invalid email format" do
    visit new_user_registration_path
    fill_in "First name", with: "Test"
    fill_in "Last name", with: "User"
    fill_in "Email", with: "invalid-email"
    select 'Landlord', from: 'user_role'
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    click_button "Sign up"
    
    expect(page).to have_content("Email is invalid")
  end

  scenario "User attempts to sign up with too short password" do
    visit new_user_registration_path
    fill_in "First name", with: "Test"
    fill_in "Last name", with: "User"
    fill_in "Email", with: "test@example.com"
    select 'Landlord', from: 'user_role'
    fill_in "Password", with: "short"
    fill_in "Password confirmation", with: "short"
    click_button "Sign up"
    
    expect(page).to have_content("Password is too short")
  end

  scenario "User attempts to sign up without selecting a role" do
    visit new_user_registration_path
    fill_in "First name", with: "Test"
    fill_in "Last name", with: "User"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    click_button "Sign up"
    
    expect(page).to have_content("Role can't be blank")
  end

  scenario "User attempts to sign up with already taken email" do
    create(:user, email: "test@example.com")
    visit new_user_registration_path
    fill_in "First name", with: "Test"
    fill_in "Last name", with: "User"
    fill_in "Email", with: "test@example.com"
    select 'Landlord', from: 'user_role'
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    click_button "Sign up"
    
    expect(page).to have_content("Email has already been taken")
  end
end
