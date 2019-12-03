require 'rails_helper'

describe 'Session', type: :feature do

  # create user
  let(:user) {FactoryBot.create(:test_user)}

  describe 'login' do
    before do
      # go to login form
      visit login_path
    end

    context 'login_by_invalid_information' do
      it 'redirect_login_form_and_describe_error_messages' do
        # post by invalid information
        fill_in 'session_email', with: ''
        fill_in 'session_password', with: ''
        click_button 'commit_button'

        expect(current_path).to eq login_path
        expect(page).to have_selector('.alert')
        expect(page).to have_link 'ログイン'
        expect(page).not_to have_link 'ログアウト'
      end
    end

    context 'login_by_valid_information' do
      it 'redirect_to_user_page' do
        # post by valid messages
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button 'commit_button'

        expect(current_path).to eq user_path(user)
        expect(page).to have_content user.name
        expect(page).not_to have_link 'ログイン'
        expect(page).to have_link 'ログアウト'
      end
    end
  end

  describe 'logout' do

    before do
      # login
      visit login_path
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_button 'commit_button'
    end

    describe 'execute_logout' do
      context 'logout' do
        it 'delete_sessions_and_redirect_to_root_page' do
          click_link 'ログアウト'

          expect(current_path).to eq root_path
          expect(page).to have_link 'ログイン'
          expect(page).not_to have_link 'ログアウト'
        end
      end
    end
  end
end
