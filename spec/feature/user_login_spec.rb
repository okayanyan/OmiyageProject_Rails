require 'rails_helper'

describe 'Session', type: :feature do

  # create user
  let(:user) {FactoryBot.create(:test_user)}

  describe 'login' do 
    describe 'describe_login_link' do
      context 'not_login' do
        before do
          visit root_path
        end
        it 'describe_login_link' do
          expect(page).to have_link 'ログイン'
          expect(page).not_to have_link 'ログアウト'
        end
      end
    end

    describe 'execute_login' do
      before do
        # go to login form
        visit login_path
      end

      context 'login_by_invalid_information' do
        before do
          # post by invalid information
          fill_in 'session_email', with: ''
          fill_in 'session_password', with: ''
          click_button 'commit_button'
        end
        it 'redirect_login_form_and_describe_error_messages' do
          expect(current_path).to eq login_path
          expect(page).to have_selector('.alert')
        end
      end

      context 'login_by_valid_information' do
        before do
          # post by valid messages
          fill_in 'session_email', with: user.email
          fill_in 'session_password', with: user.password
          click_button 'commit_button'
        end
        it 'redirect_to_user_page' do
          expect(current_path).to eq user_path(user)
          expect(page).to have_content user.name
        end
      end
    end
  end

  describe 'logout' do

    before do
      # login
      #post :create, params: {session: 
      #                        {email: user.email, password: user.password}}
      #visit root_path
    end

    describe ' describe_logout_link' do
      context 'already_login' do
        it 'don\'t_describe_login_link' do
          #expect(page).not_to have_link 'ログイン'
          #expect(page).to have_link 'ログアウト'
        end
      end
    end

    describe 'execute_logout' do
      context 'logout' do
        it 'delete_sessions_and_redirect_to_root_page' do
          # TODO
        end
      end
    end
  end
end
