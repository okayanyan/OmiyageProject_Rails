require 'rails_helper'

describe 'PostNew', type: :feature do

  let(:post1) {FactoryBot.create(:test_post)}
  let(:user1) {post1.user}
  before do
    # login
    visit login_path
    fill_in 'session_email', with: user1.email
    fill_in 'session_password', with: user1.password
    click_button 'commit_button'
    visit new_post_path
  end

  context 'invalid_information' do
    it 'return_post_form' do
      post_before = Post.all().count
      fill_in 'post_title', with: ''
      select '北海道', from: '都道府県：'
      select 3, from: '評価：'
      fill_in 'post_content', with: ''
      click_button 'commit_button'
      post_after = Post.all().count
      expect(current_path).to eq new_post_path
      expect(post_before).to eq post_after
    end
  end

  context 'valid_information' do
    it 'return_post_form' do
      post_before = Post.all().count
      fill_in 'post_title', with: 'test_post'
      select '北海道', from: '都道府県：'
      select 3, from: '評価：'
      fill_in 'post_content', with: 'test_content'
      click_button 'commit_button'
      post_after = Post.all().count
      expect(page).to have_content "投稿に成功しました。"
      expect(post_before).to eq post_after - 1
    end
  end

end