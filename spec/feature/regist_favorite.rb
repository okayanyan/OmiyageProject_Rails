require 'rails_helper'

describe 'Favorite', type: :feature do

  let(:post1) {FactoryBot.create(:test_post1)}
  let(:user1) {post1.user}
  before do
    # login
    visit login_path
    fill_in 'session_email', with: user1.email
    fill_in 'session_password', with: user1.password
    click_button 'commit_button'
  end

  context 'regist_and_unregist_favorite' do
    it 'success_regist' do
      visit root_path
      expect(page).to have_content 'お気に入り0件'
      expect(page).not_to have_content 'お気に入り1件'

      visit post_path(post1)
      expect(page).to have_content 'お気に入り0件'
      expect(page).not_to have_content 'お気に入り1件'
      expect(page).to have_selector 'input', text: 'お気に入り登録' 

      # favorite
      click_on 'お気に入り登録' 
      expect(current_page).to eq post_path(post1)
      expect(page).not_to have_content 'お気に入り0件'
      expect(page).to have_content 'お気に入り1件'
      expect(page).to have_selector 'input', text: 'お気に入り解除'
      
      visit root_path
      expect(page).not_to have_content 'お気に入り0件'
      expect(page).to have_content 'お気に入り1件'

      # unfavorite
      visit post_path(post1)
      click_on 'お気に入り解除' 
      expect(current_page).to eq post_path(post1)
      expect(page).to have_content 'お気に入り0件'
      expect(page).not_to have_content 'お気に入り1件'
      expect(page).to have_selector 'input', text: 'お気に入り登録'
      
      visit root_path
      expect(page).to have_content 'お気に入り0件'
      expect(page).not_to have_content 'お気に入り1件'
    end
  end
end