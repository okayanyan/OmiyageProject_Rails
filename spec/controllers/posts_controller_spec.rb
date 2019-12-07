require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe 'post#index' do
    it 'return_success_response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
  describe 'post#show' do
    let(:prefecture) {Prefecture.new(id: 1, name: "北海道")}
    let(:correct_user) {User.new(id: 1, name: "user", email: "user@example.com",
                          password: "password", password_confirmation: "password")}
    let(:correct_post) {correct_user.post.new(id: 1, title: "test_title", image_key: "static/Miyalog/image/no_image.jpg",
                          prefecture: prefecture, evaluation: 1, content: "test_content")}
    it 'return_success_response' do
      post :show, params: {id: correct_post.id}
      expect(response).to have_http_status(:success)
    end
  end
  
  #describe "posts#new" do
  #  it 'return_success_response' do
  #    get :new
  #    expect(response).to have_http_status(:success)
  #  end
  #end

  #describe 'post#create' do
  #  it 'return_success_response' do
  #    post :create, params: {id: '1', post: {user: 1, title: "test", 
  #          image_key: "test", prefecture: 1, evaluation: 1, content: "test"}}
  #    expect(response).to have_http_status(:success)
  #  end
  #end
  
  #describe 'post#edit' do
  #  it 'return_success_response' do
  #    get :edit, params: {id: '1'}
  #    expect(response).to have_http_status(:success)
  #  end
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
