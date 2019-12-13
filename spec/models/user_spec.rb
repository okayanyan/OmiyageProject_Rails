require 'rails_helper'

describe User do

  let(:user1) {FactoryBot.create(:test_user)}

  describe 'save user.' do
        
    shared_examples_for 'valid user.' do
      it { expect(user.valid?).to be_truthy }
    end
  
    shared_examples_for 'invalid user.' do
      it { expect(user.valid?).to be_falsey }
    end
                        
    context 'name is empty,' do
      let(:user) {user1}
      before do
        user.name = ""
      end
      it_behaves_like 'invalid user.'
    end

    context 'name is too long.' do
      let(:user) {user1}
      before do
        user.name = "a"*21
      end
      it_behaves_like 'invalid user.'
    end

    context 'email is wrong.' do
      let(:user) {user1}
      before do
        user.email = "example.com"
      end
      it_behaves_like 'invalid user.'
    end

    context 'password is empty.' do
      let(:user) {user1}
      before do
        user.password = ""
        user.password_confirmation = ""
      end
      it_behaves_like 'invalid user.'
    end

    context 'password is too long.' do
      let(:user) {user1}
      before do
        user.password = "a"*21
        user.password_confirmation = "a"*21
      end
      it_behaves_like 'invalid user.'
    end

    context 'password is no match for confirmation.' do
      let(:user) {user1}
      before do
        user.password = "password"
        user.password_confirmation = "password1"
      end
      it_behaves_like 'invalid user.'
    end

    context 'correct user information.' do
      let(:user) {user1}
      it_behaves_like 'valid user.'
    end
  end

  describe 'delete_user' do
    let(:user) {user1}
    it 'deleted_user' do
      id = user.id
      user.destroy
      expect(User.where(id: id).count).to eq 0
    end
  end

  describe 'Follow' do

    let(:user1) {FactoryBot.create(:test_user)}
    let(:user2) {FactoryBot.create(:test_user2)}
    
    # followメソッドテスト
    describe 'follow_user' do
      context 'follow_self' do
        it 'invalid_following' do
          expect(user1.following?(user1)).to eq false
          user1.follow(user1)
          expect(user1.following?(user1)).to eq false
        end
      end
      context 'follow_other' do
        it 'valid_following' do
          expect(user1.following?(user2)).to eq false
          user1.follow(user2)
          expect(user1.following?(user2)).to eq true
        end
      end
    end


    # unfollowメソッドテスト
    describe 'unfollow_user' do
      #事前にリレーション
      before do
        user1.follow(user2)
      end

      context 'unfollow_other' do
        it 'valid_unfollowing' do
          expect(user1.following?(user2)).to eq true
          user1.unfollow(user2)
          expect(user1.following?(user2)).to eq false
        end
      end
    end
  end

end
