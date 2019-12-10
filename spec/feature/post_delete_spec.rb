require 'rails_helper'

describe 'PostDelete', type: :feature do
  let(:post1) {FactoryBot.create(:test_post)}
  let(:post2) {FactoryBot.create(:test_post2)}
  let(:user1) {post1.user}

  before do
    # login
    visit login_path
    fill_in 'session_email', with: user1.email
    fill_in 'session_password', with: user1.password
    click_button 'commit_button' 
  end

  describe 'BeforeDelete' do

    context 'not login' do
      before do
        click_on 'ログアウト'
        visit post_path(id: post1.id)
      end
      it 'not_visible_edit_button' do
        expect(page).not_to have_content('投稿を削除する')
      end
    end
    
    context 'other_user\'s_post' do
      before do
        # go to edit page
        visit post_path(id: post2.id)
      end
      it 'not_visible_edit_button' do
        expect(page).not_to have_content('投稿を削除する')
      end
    end

  end
  
  describe 'Delete' do

    before do
      # go to edit page
      visit post_path(id: post1.id)
    end

    context 'delete' do
      it 'success_delete_and_redirect_root_page' do
        id = post1.id
        click_link 'delete_button'
        expect(current_path).to eq root_path
        expect(page).to have_content "削除に成功しました。"
        expect(Post.find_by(id: id).nil?).to eq true
      end
    end

  end

end