require 'rails_helper'

RSpec.describe 'User Reset Password', type: :system do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
  end

  it 'allows user to reset password' do
    click_link 'Forgot your password?'
    expect redirect_to new_user_password_path
    fill_in 'Email', with: user.email
    click_button 'Send me reset password instructions'
    expect redirect_to new_user_session_path
    expect(page).to have_content('You will receive an email with instructions on how to reset your password in a few minutes.')
  end

  it 'displays error message for invalid password reset' do
    click_link 'Forgot your password?'
    expect redirect_to new_user_password_path
    fill_in 'Email', with: 'sdfsdf@error.com'
    click_button 'Send me reset password instructions'
    expect redirect_to new_user_password_path
    expect(page).to have_content("Email not found")
    fill_in 'Email', with: ''
    click_button 'Send me reset password instructions'
    expect redirect_to new_user_password_path
    expect(page).to have_content("Email can't be blank")

  end
end