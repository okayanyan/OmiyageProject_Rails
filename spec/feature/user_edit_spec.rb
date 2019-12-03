require 'rails_helper'

describe 'UserEdit', type: :feature do

  let(:user) {FactoryBot.create(:test_user)}

  before do
    # login
    visit login_path
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    click_button 'commit_button'

    # go to user edit form
    visit edit_user_path(user)
  end

  context 'edit_by_invalid_information' do
    it 'redirect_to_edit_form' do
      # post
      fill_in 'user_name', with: 'test_user_edit'
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: ''
      click_button 'commit_button'

      expect(current_path).to eq edit_user_path(user)
      expect(page).to have_selector('#error_explanation')
      expect(page).to have_field 'Name', with: user.name
    end
  end

  context 'edit_by_valid_information' do
    it 'redirect_to_user_page' do
      fill_in 'user_name', with: 'test_user_edit'
      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'commit_button'

      expect(current_path).to eq user_path(user)
      expect(page).to have_content 'test_user_edit'
    end
  end

end