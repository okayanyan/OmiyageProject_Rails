require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'save_post' do

    # post作成
    let(:prefecture) {Prefecture.new(id: 1, name: "北海道")}
    let(:correct_user) {User.new(id: 1, name: "user", email: "user@example.com",
                          password: "password", password_confirmation: "password")}
    let(:correct_post) {correct_user.post.new(id: 1, title: "test_title", image_key: "static/Miyalog/image/no_image.jpg",
                          prefecture: prefecture, evaluation: 1, content: "test_content")}

    shared_examples_for 'valid_post.' do
      it { expect(post.valid?).to be_truthy }
    end
  
    shared_examples_for 'invalid_post.' do
      it { expect(post.valid?).to be_falsey }
    end

    context 'user_is_none' do
      let(:post) {correct_post}
      before do
        post.user = nil
      end
      it_behaves_like 'invalid_post.'
    end
    
    context 'title_is_none' do
      let(:post) {correct_post}
      before do
        post.title = nil
      end
      it_behaves_like 'invalid_post.'
    end

    context 'title_is_too_long' do
      let(:post) {correct_post}
      before do
        post.title = "a" * 31
      end
      it_behaves_like 'invalid_post.'
    end

    context 'prefecture_is_none' do
      let(:post) {correct_post}
      before do
        post.prefecture = nil
      end
      it_behaves_like 'invalid_post.'
    end

    context 'content_is_none' do
      let(:post) {correct_post}
      before do
        post.content = nil
      end
      it_behaves_like 'invalid_post.'
    end

    context 'content_is_too_long' do
      let(:post) {correct_post}
      before do
        post.content = "a" * 1001
      end
      it_behaves_like 'invalid_post.'
    end

    context 'evaluations_is_none' do
      let(:post) {correct_post}
      before do
        post.user = nil
      end
      it_behaves_like 'invalid_post.'
    end

    context 'valid_information' do
      let(:post) {correct_post}
      it_behaves_like 'valid_post.'
    end
    
  end
end
