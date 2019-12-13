require 'rails_helper'

RSpec.describe FollowUser, type: :model do
  describe 'FollowRelation' do

    let(:relation) {FactoryBot.create(:follow_relation1)}
    
    describe 'SaveFollowRelations' do
      
      shared_examples_for 'valid_follow_relation.' do
        it { expect(relation.valid?).to be_truthy }
      end
    
      shared_examples_for 'invalid_follow_relation.' do
        it { expect(relation.valid?).to be_falsey }
      end

      context 'non_follow_user_id' do
        before do
          relation.following_user_id = nil
        end
        it_behaves_like 'invalid_follow_relation.'
      end

      context 'non_target_user_id' do
        before do
          relation.target_user_id = nil
        end
        it_behaves_like 'invalid_follow_relation.'
      end

      context 'valid_information' do
        it_behaves_like 'valid_follow_relation.'
      end
    end

    describe 'DeleteRelation' do
      context 'delete' do
        it 'deleted_folloW_relation' do
          id = relation.id
          relation.destroy
          expect(FollowUser.where(id: id).count).to eq 0
        end
      end
    end

  end
end
