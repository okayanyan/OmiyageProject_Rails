require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'favorite' do
    
    let(:favorite1) {FactoryBot.create(:test_favorite)}

    shared_examples_for 'valid_favorite.' do
      it { expect(favorite.valid?).to be_truthy }
    end
  
    shared_examples_for 'invalid_favorite.' do
      it { expect(favorite.valid?).to be_falsey }
    end

    context 'non_user' do
      let(:favorite) {favorite1}
      before do
        favorite.user = nil  
      end
      it_behaves_like 'invalid_favorite.'
    end

    context 'non_post' do
      let(:favorite) {favorite1}
      before do
        favorite.post = nil
      end
      it_behaves_like 'invalid_favorite.'
    end

    context 'valid_information' do
      let(:favorite) {favorite1}
      it_behaves_like 'valid_favorite.'
    end

  end
end
