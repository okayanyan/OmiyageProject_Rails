require 'rails_helper'

describe User do

  let(:correct_user) {User.new(name: "user", email: "user@example.com",
                        password: "password", password_confirmation: "password")}

  describe 'save user.' do
        
    shared_examples_for 'valid user.' do
      it { expect(user.valid?).to be_truthy }
    end
  
    shared_examples_for 'invalid user.' do
      it { expect(user.valid?).to be_falsey }
    end
                        
    context 'name is empty,' do
      let(:user) {correct_user}
      before do
        user.name = ""
      end
      it_behaves_like 'invalid user.'
    end

    context 'name is too long.' do
      let(:user) {correct_user}
      before do
        user.name = "a"*21
      end
      it_behaves_like 'invalid user.'
    end

    context 'email is wrong.' do
      let(:user) {correct_user}
      before do
        user.email = "example.com"
      end
      it_behaves_like 'invalid user.'
    end

    context 'password is empty.' do
      let(:user) {correct_user}
      before do
        user.password = ""
        user.password_confirmation = ""
      end
      it_behaves_like 'invalid user.'
    end

    context 'password is too long.' do
      let(:user) {correct_user}
      before do
        user.password = "a"*21
        user.password_confirmation = "a"*21
      end
      it_behaves_like 'invalid user.'
    end

    context 'password is no match for confirmation.' do
      let(:user) {correct_user}
      before do
        user.password = "password"
        user.password_confirmation = "password1"
      end
      it_behaves_like 'invalid user.'
    end

    context 'correct user information.' do
      let(:user) {correct_user}
      it_behaves_like 'valid user.'
    end
  end

  describe 'delete_user' do
    let(:post) {correct_user.post.new(title: 'test', image_key: nil, 
                  prefecture_id: 1, evaluation: 1, content: 'test_content')}
    before do
      correct_user.destroy
    end
    # ユーザーを削除すると、投稿も消える
    it 'deleted_user_and_post' do
      expect(Post.where(id: post.id).count).to eq 0
    end
  end

end
