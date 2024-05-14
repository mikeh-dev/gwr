require 'rails_helper'

RSpec.describe 'User Sign In', type: :system do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
  end

  it 'allows a user to sign in' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content('Signed in successfully.')
  end

  it 'displays an error message with invalid credentials' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrong_password'
    click_button 'Sign in'

    expect(page).to have_content('Invalid Email or password.')
  end
end