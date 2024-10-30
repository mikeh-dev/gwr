require 'rails_helper'

RSpec.describe 'User Sign In', type: :system do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
  end


  context 'with valid credentials' do
    it 'allows a user to sign in' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'

      expect(page).to have_content('Signed in successfully.')
    end
  end

  context 'with invalid credentials' do
    it 'displays an error message when user provides invalid credentials' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'wrong_password'
      click_button 'Sign in'

      expect(page).to have_content('Invalid Email or password.')
    end

    it 'displays an error message when user provides invalid email' do
      fill_in 'Email', with: 'invalid_email'
      fill_in 'Password', with: user.password
      click_button 'Sign in'

      expect(page).to have_content('Invalid Email or password.')
    end

    it 'displays an error message when user provides empty fields ' do
      click_button 'Sign in'

      expect(page).to have_content('Invalid Email or password.')
    end
  end
end