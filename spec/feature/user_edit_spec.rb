require 'rails_helper'

describe 'UserEdit', type: :feature do

  let(:user) {FactoryBot.create(:test_user)}

  before do
    # login
    visit login_path
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    click_button 'commit_button'
  end

  describe 'edit_user' do
    before do
      # go to user edit form
      click_link 'edit_user_link'
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
        expect(page).to have_content "更新が成功しました。"
      end
    end
  end

  describe 'delete_user' do
    before do
      # go to user edit form
      visit user_path(user)
    end
    context 'click_delete_button' do
      it 'delete_user_and_redirect_root_page' do
        click_link 'delete_user_link'
        expect(current_path).to eq root_path
        expect(page).to have_content "ユーザーを削除しました。"

        visit login_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button 'commit_button'
        expect(current_path).to eq login_path
      end
    end

  end

end