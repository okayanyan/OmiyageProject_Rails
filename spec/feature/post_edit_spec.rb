require 'rails_helper'

describe 'PostEdit', type: :feature do
  
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

  describe 'BeforeEdit' do

    before do
      # go to edit page
      visit post_path(id: post2.id)
    end
    context 'other_user\'s_post' do
      it 'not_visible_edit_button' do
        expect(page).not_to have_content('投稿を編集する')
      end
    end

  end
  
  describe 'Edit' do

    before do
      # go to edit page
      visit post_path(id: post1.id)
      click_link 'edit_button'
    end

    context 'invalid_information' do
      it 'return_edit_post_page' do
        fill_in 'post_title', with: ''
        select '北海道', from: '都道府県：'
        select 5, from: '評価：'
        fill_in 'post_content', with: ''
        click_button 'commit_button'
        expect(current_path).to eq edit_post_path(id: post1.id)
      end
    end
  
    context 'non_regist_information' do
      it 'failed_return_post_page' do
        fill_in 'post_title', with: 'edit_title'
        find('#post_prefecture').click
        find('#post_prefecture').set('青森')
        find('#post_evaluation').click
        find('#post_evaluation').set('5')
        fill_in 'post_content', with: 'edit_content'
        click_on 'cancel_button'
        cnt_star = all('.star_on').size
        expect(current_path).to eq post_path(id: post1.id)
        expect(page).to have_content(post1.user.name)
        expect(page).to have_content(post1.prefecture.name)
        expect(cnt_star).to eq(post1.evaluation)
        expect(page).to have_content(post1.content)
        expect(page).not_to have_content('edit_title')
        expect(page).not_to have_content('青森')
        expect(cnt_star).not_to eq(5)
        expect(page).not_to have_content('edit_content')
      end
    end
  
    context 'valid_information' do
      it 'success_update_and_return_post_page' do
        fill_in 'post_title', with: 'edit_title'
        # TODO(セレクト選択再調査)
        #select('2', from: 'post_prefecture').select_option
        #find('#post_prefecture').click
        #find('#post_prefecture').set('青森')
        #find('#post_evaluation').click
        #find('#post_evaluation').set('5')
        fill_in 'post_content', with: 'edit_content'
        click_on 'commit_button'
        cnt_star = all('.star_on').size
        expect(current_path).to eq post_path(id: post1.id)
        expect(page).to have_content "更新に成功しました。"
        expect(page).not_to have_content(post1.title)
        expect(page).to have_content(post1.user.name)
        #expect(page).not_to have_content(post1.prefecture.name)
        #expect(cnt_star).not_to eq(post1.evaluation)
        expect(page).not_to have_content(post1.content)
        expect(page).to have_content('edit_title')
        #expect(page).to have_content('青森')
        #expect(cnt_star).to eq(5)
        expect(page).to have_content('edit_content')
      end
    end

  end

end