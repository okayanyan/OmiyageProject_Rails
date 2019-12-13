require 'rails_helper'

describe 'Folllow', type: :feature do

  let(:post1) {FactoryBot.create(:test_post)}
  let(:post2) {FactoryBot.create(:test_post2)}
  let(:user1) {post1.user}
  let(:user2) {post2.user}
  let(:user3) {FactoryBot.create(:test_user3)}
  let(:user4) {FactoryBot.create(:test_user4)}
  
  before do
    # create follow relation
    user1.follow(user2)
    user2.follow(user1)
    user1.follow(user3)
    user4.follow(user1)
    # login
    visit login_path
    fill_in 'session_email', with: user1.email
    fill_in 'session_password', with: user1.password
    click_button 'commit_button' 
    visit user_path(user1)
  end

  describe 'visible_follow_follower_information' do
    context 'my_user_page' do
      it 'visible_follow_follower_information' do 
        # visit user1 page
        expect(page).to have_content('2 followings')
        expect(page).to have_content('2 followers')
        expect(page).not_to have_content('フォロー')
        expect(page).not_to have_content('フォロー解除')
        
        # check follow user
        click_on '2 followings', id: "user_1_followings", match: :first     # 2 links exists because col-transformation
        expect(current_path).to eq following_user_path(user1)
        expect(page).to have_content(user2.name)
        expect(page).to have_content(user3.name)
        expect(all('#user_2_follow_button').size).to eq 0
        expect(all('#user_2_unfollow_button').size).to eq 1
        expect(all('#user_3_follow_button').size).to eq 0
        expect(all('#user_3_unfollow_button').size).to eq 1
        
        # check follower user
        click_on '2 followers', id: "user_1_followers", match: :first
        expect(current_path).to eq followers_user_path(user1)
        expect(page).to have_content(user2.name)
        expect(page).to have_content(user4.name)
        expect(all('#user_2_follow_button').size).to eq 0
        expect(all('#user_2_unfollow_button').size).to eq 1
        expect(all('#user_4_follow_button').size).to eq 1
        expect(all('#user_4_unfollow_button').size).to eq 0
      end
    end

    context 'other_user_page' do
      it 'visible_follow_follower_information' do 
        # visit user1 page
        click_on '2 followings', id: "user_1_followings", match: :first
        click_on user2.name
        expect(current_path).to eq user_path(user2)
        expect(page).to have_content('1 following')
        expect(page).to have_content('1 follower')
        expect(all('#user_2_follow_button').size).to eq 0
        expect(all('#user_2_unfollow_button').size).to eq 2
        
        visit user_path(user1)
        click_on '2 followers', id: "user_1_followers", match: :first
        click_on user4.name
        expect(current_path).to eq user_path(user4)
        expect(page).to have_content('1 following')
        expect(page).to have_content('0 follower')
        expect(all('#user_4_follow_button').size).to eq 2
        expect(all('#user_4_unfollow_button').size).to eq 0
      end
    end

    context 'my_post_page' do
      it 'not_visible_follow_button' do 
        # visit user1's post page
        visit post_path(post1)
        expect(all('#user_1_follow_button').size).to eq 0
        expect(all('#user_1_unfollow_button').size).to eq 0
      end
    end

    context 'other_user\'s_post_page' do
      it 'visible_follow_button' do 
        # visit user1's post page
        visit post_path(post2)
        expect(all('#user_2_follow_button').size).to eq 0
        expect(all('#user_2_unfollow_button').size).to eq 1
      end
    end
  end
  
  describe 'follow_function' do

    context 'follow_user2_in_my_user_followings_page' do
      it 'change_follow_follower_count_and_button_text' do
        click_on '2 followings', id: "user_1_followings", match: :first      # 2 links exists because col-transformation
        
        # unfollow
        click_on 'フォロー解除', id: "user_#{user2.id}_unfollow_button"
        expect(current_path).to eq following_user_path(user1)
        expect(all('#user_2_follow_button').size).to eq 0
        expect(all('#user_2_unfollow_button').size).to eq 0
        expect(page).to have_selector '#user_1_followings', text: '1 followings'
      end
    
    end

    context 'follow_and_unfollow_user2_my_followers_page' do
      it 'change_follow_follower_count_and_button_text' do
        click_on '2 followers', id: "user_1_followers", match: :first      # 2 links exists because col-transformation
        
        # unfollow
        click_on 'フォロー解除', id: "user_#{user2.id}_unfollow_button"
        expect(current_path).to eq followers_user_path(user1)
        expect(all('#user_2_follow_button').size).to eq 1
        expect(all('#user_2_unfollow_button').size).to eq 0
        expect(page).to have_selector '#user_1_followings', text: '1 followings'
        expect(page).to have_selector '#user_2_followers', text: '0 followers'

        # follow
        click_on 'フォロー', id: "user_#{user2.id}_follow_button"
        expect(current_path).to eq followers_user_path(user1)
        expect(all('#user_2_follow_button').size).to eq 0
        expect(all('#user_2_unfollow_button').size).to eq 1
        expect(page).to have_selector '#user_1_followings', text: '2 followings'
        expect(page).to have_selector '#user_2_followers', text: '1 followers'
      end
    end

    context 'follow_and_unfollow_user2_other_user_page' do
      it 'change_follow_follower_count_and_button_text' do
        visit user_path(user2)
        expect(page).to have_content('1 following')
        expect(page).to have_content('1 follower')
        expect(all('#user_2_follow_button').size).to eq 0
        expect(all('#user_2_unfollow_button').size).to eq 2

        # unfollow
        click_on 'フォロー解除', id: 'user_2_unfollow_button', match: :first
        expect(page).to have_content('1 following')
        expect(page).to have_content('0 follower')
        expect(all('#user_2_follow_button').size).to eq 2
        expect(all('#user_2_unfollow_button').size).to eq 0

        # follow
        click_on 'フォロー', id: 'user_2_follow_button', match: :first
        expect(page).to have_content('1 following')
        expect(page).to have_content('1 follower')
        expect(all('#user_2_follow_button').size).to eq 0
        expect(all('#user_2_unfollow_button').size).to eq 2
      end
    end


    context 'follow_and_unfollow_user2_other_user\'s_post_page' do
      it 'change_follow_follower_count_and_button_text' do
        visit post_path(post2)
        expect(all('#user_2_follow_button').size).to eq 0
        expect(all('#user_2_unfollow_button').size).to eq 1

        # unfollow
        click_on 'フォロー解除', id: 'user_2_unfollow_button'
        expect(all('#user_2_follow_button').size).to eq 1
        expect(all('#user_2_unfollow_button').size).to eq 0

        # follow
        click_on 'フォロー', id: 'user_2_follow_button'
        expect(all('#user_2_follow_button').size).to eq 0
        expect(all('#user_2_unfollow_button').size).to eq 1
      end
    end
  end
end