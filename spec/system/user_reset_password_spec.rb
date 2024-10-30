require 'rails_helper'

RSpec.describe 'User Reset Password', type: :system do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
  end

  context 'requesting password reset' do
    
    it 'sends reset instructions to existing user' do
      click_link 'Forgot your password?'
      expect(current_path).to eq(new_user_password_path)
      
      fill_in 'Email', with: user.email
      expect {
        click_button 'Send me reset password instructions'
      }.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_content('You will receive an email with instructions')
    end

    it 'shows error for non-existent email' do
      click_link 'Forgot your password?'
      fill_in 'Email', with: 'nonexistent@example.com'
      
      expect {
        click_button 'Send me reset password instructions'
      }.not_to change { ActionMailer::Base.deliveries.count }

      expect(current_path).to eq(user_password_path)
      expect(page).to have_content("Email not found")
    end

    it 'shows error for blank email' do
      click_link 'Forgot your password?'
      fill_in 'Email', with: ''
      
      expect {
        click_button 'Send me reset password instructions'
      }.not_to change { ActionMailer::Base.deliveries.count }

      expect(current_path).to eq(user_password_path)
      expect(page).to have_content("Email can't be blank")
    end
  end

  context 'resetting password' do
    let(:token) { user.send_reset_password_instructions }

    it 'allows user to set new password with valid token' do
      visit edit_user_password_path(reset_password_token: token)
      
      fill_in 'New password', with: 'newpassword123'
      fill_in 'Confirm new password', with: 'newpassword123'
      click_button 'Change password'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Your password has been changed successfully')
    end

    it 'shows error with password confirmation mismatch' do
      visit edit_user_password_path(reset_password_token: token)
      
      fill_in 'New password', with: 'newpassword123'
      fill_in 'Confirm new password', with: 'different123'
      click_button 'Change password'

      expect(page).to have_content("Password confirmation doesn't match")
    end

    it 'shows error with invalid token' do
      visit edit_user_password_path(reset_password_token: 'invalid_token')
      
      fill_in 'New password', with: 'newpassword123'
      fill_in 'Confirm new password', with: 'newpassword123'
      click_button 'Change password'

      expect(page).to have_content('Reset password token is invalid')
    end
  end
end