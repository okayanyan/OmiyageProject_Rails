require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe 'post#index' do
    it 'return_success_response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
  describe 'post#show' do
    let(:post1) {FactoryBot.create(:test_post)}

    it 'return_success_response' do
      post :show, params: {id: post1.id}
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "posts#new" do
    let(:user1) {FactoryBot.create(:test_user)}

    it 'return_success_response' do
      get :new
      expect(response).to redirect_to login_path
    end
  end

  describe 'post#create' do
    let(:user1) {FactoryBot.create(:test_user)}

    it 'return_success_response' do
      post :create, params: {id: '1', post: {user: 1, title: "test", 
            prefecture: 1, evaluation: 1, content: "test"}}
      expect(response).to redirect_to login_path
    end
  end
  
  #describe 'post#edit' do
  #  it 'return_success_response' do
  #    get :edit, params: {id: '1'}
  #    expect(response).to have_http_status(:success)
  # end
  #end
  
  #describe 'post#update' do
  #  it 'return_success_response' do
  #    post :update, params: {id: '1', post: {user: 1, title: "test_edit", 
  #      image_key: "test", prefecture: 1, evaluation: 1, content: "test"}}
  #    expect(response).to have_http_status(:success)
  #  end
  #end
  
  #describe 'post#delete' do
  #  before do
  #    post :update, params: {id: '1', post: {user: 1, title: "test_edit", 
  #      image_key: "test", prefecture: 1, evaluation: 1, content: "test"}}
  #  end
  #  it 'return_success_response' do
  #    delete :destroy, params: {id: '1'}
  #    expect(response).to have_http_status(:success)
  #  end
  #end
  
end
