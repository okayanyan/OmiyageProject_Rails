require 'rails_helper'

describe 'Sign up', type: :feature do

  describe 'create user.' do
    before do
      # go to form to create user
      visit new_user_path
      ActionMailer::Base.deliveries.clear
    end

    context 'invalid user information' do
      it 'failed to create user' do
        fill_in 'user_name', with: ''
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: ''
        fill_in 'user_password_confirmation', with: ''
        click_button 'commit_button'

        expect(current_path).to eq new_user_path
        expect(page).to have_selector('#error_explanation')
      end
    end

    context 'valid user information' do
      it 'success to create user ' do
        fill_in 'user_name', with: 'test_user'
        fill_in 'user_email', with: 'test@test.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button 'commit_button'
        
        # set token by myself because to save in testcase
        user = User.find_by(email: "test@test.com")
        user.prepare_activate
        user.save
        expect(current_path).to eq root_path
        expect(page).to have_content "ユーザーの仮登録が完了しました。"
        expect(ActionMailer::Base.deliveries.size).to eq 1
        expect(user.activated).to be_falsey
        
        # check to log in by new account(non activated)
        visit login_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button 'commit_button'
        expect(current_path).to eq login_path
        expect(page).to have_css '.alert-danger'
        expect(page).to have_link 'ログイン'
        expect(page).not_to have_link 'ログアウト'

        # activate
        visit edit_account_activation_path(id: "invalid token", email: user.email)
        expect(current_path).to eq root_path
        expect(page).to have_content '有効化用のリンクが無効です。'

        visit edit_account_activation_path(id: user.activation_token, email: user.email)
        # get user because account was activated
        user = User.find_by(email: user.email)
        expect(user.activated).to be_truthy
        expect(current_path).to eq user_path(user)
        expect(page).to have_content 'アカウントを有効化しました。'
      end
    end
  end

end
