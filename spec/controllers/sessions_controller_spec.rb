require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "describe_form_to_login" do
    before do
      get :new
    end
    it "returns_http_success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'session_function' do
    
    let(:user) {FactoryBot.create(:test_user)} 

    describe 'login' do
      context 'login_by_invalid_information' do
        before do
          post :create, params: {session: 
                                  {email: "", password: ""}}
        end
        it 'redirect_to_form' do
          expect(response).to redirect_to login_path
        end
      end
  
      context 'login_by_valid_information' do
        before do
          post :create, params: {session: 
                                  {email: user.email, password: user.password}}
        end
        it 'redirect_to_user_page' do
          expect(response).to redirect_to user_path(user)
        end
      end
    end

    describe 'logout' do
      before do
        # login
        post :create, params: {session: 
                                {email: user.email, password: user.password}}
      end

      context 'logout' do
        it 'delete_session_and_redirect_root_page' do
          #delete :destroy
          #expect(response).to redirect_to root_path
        end
      end
    end
  
  end
  
end
