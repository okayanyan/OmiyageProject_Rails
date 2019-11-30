require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "describe form to create user" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Create user' do
    context 'post invalid information' do
      it 'redirect to form' do
        post :create, params: {user: {name: "", email: "", 
                            password: "", password_confirmation: ""}}
        expect(response).to redirect_to new_user_path
      end
    end

    context 'post valid information' do
      it 'redirect to user page' do
        post :create, params: {user: {name: "test_user", email: "test@test.com", 
                            password: "password", password_confirmation: "password"}}
        user = User.find_by(email: "test@test.com")
        expect(response).to redirect_to user_path(user)
      end
    end
  end

end
