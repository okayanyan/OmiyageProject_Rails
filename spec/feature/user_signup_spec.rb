require 'rails_helper'

describe 'Sign up', type: :feature do

  describe 'create user.' do
    before do
      visit new_user_path
    end

    context 'invalid user information' do
      before do
        fill_in 'user_name', with: ''
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: ''
        fill_in 'user_password_confirmation', with: ''
        click_button 'commit_button'
      end
      it 'failed to create user' do
        expect(current_path).to eq new_user_path
        expect(page).to have_selector('#error_explanation')
      end
    end

    context 'valid user information' do
      before do
        fill_in 'user_name', with: 'test_user'
        fill_in 'user_email', with: 'test@test.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button 'commit_button'
      end
      it 'success to create user ' do
        user = User.find_by(email: "test@test.com")
        expect(current_path).to eq user_path(user)
        expect(page).to have_content user.name
      end
    end
  end

end
