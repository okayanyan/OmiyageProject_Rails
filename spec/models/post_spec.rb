require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'save_post' do

    # post作成
    let(:post1) {FactoryBot.create(:test_post)}

    shared_examples_for 'valid_post.' do
      it { expect(post.valid?).to be_truthy }
    end
  
    shared_examples_for 'invalid_post.' do
      it { expect(post.valid?).to be_falsey }
    end

    context 'user_is_none' do
      let(:post) {post1}
      before do
        post.user = nil
      end
      it_behaves_like 'invalid_post.'
    end
    
    context 'title_is_none' do
      let(:post) {post1}
      before do
        post.title = nil
      end
      it_behaves_like 'invalid_post.'
    end

    context 'title_is_too_long' do
      let(:post) {post1}
      before do
        post.title = "a" * 31
      end
      it_behaves_like 'invalid_post.'
    end

    context 'prefecture_is_none' do
      let(:post) {post1}
      before do
        post.prefecture = nil
      end
      it_behaves_like 'invalid_post.'
    end

    context 'content_is_none' do
      let(:post) {post1}
      before do
        post.content = nil
      end
      it_behaves_like 'invalid_post.'
    end

    context 'content_is_too_long' do
      let(:post) {post1}
      before do
        post.content = "a" * 1001
      end
      it_behaves_like 'invalid_post.'
    end

    context 'evaluations_is_none' do
      let(:post) {post1}
      before do
        post.user = nil
      end
      it_behaves_like 'invalid_post.'
    end

    context 'valid_information' do
      let(:post) {post1}
      it_behaves_like 'valid_post.'
    end
    
  end
end
