require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'User_create' do
    describe 'describe_form_to_create_user' do
      it 'returns_http_success' do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  
    describe 'create_user' do
      context 'post_invalid information' do
        it 'redirect_to_form' do
          post :create, params: {user: {name: "", email: "", 
                              password: "", password_confirmation: ""}}
          expect(response).to redirect_to new_user_path
        end
      end
  
      context 'post_valid_information' do
        it 'redirect_to_user_page' do
          post :create, params: {user: {name: "test_user", email: "test@test.com", 
                              password: "password", password_confirmation: "password"}}
          user = User.find_by(email: "test@test.com")
          expect(response).to redirect_to root_path
        end
      end
    end
  end
 
  describe 'User_update' do

    let(:user) {FactoryBot.create(:test_user)}
    let(:user2) {FactoryBot.create(:test_user2)}
    
    describe 'describe_form_to_update_user' do
      
      context 'not_log_in' do
        it 'redirect_to_login_form' do
          get :edit, params: {id: '1'}
          expect(response).to redirect_to login_path
        end
      end

      # TODO(login operation)
      #context 'wrong_user' do
      #  before do
      #    # login
      #    #log_in_as(user2)
      #    
      #    #post login_path, params: {id: '2', 
      #    #        session: {email: user2.email, password: user2.password}}
      #  end
      #  it 'redirect_to_root' do
      #    get :edit, params: {id: '1'}
      #    expect(response).to redirect_to root_path
      #  end
      #end

      # TODO(login operation)
      #context 'correct_user' do
      #  before do
      #    # login
      #    #log_in_as(user)
      #    
      #    #post login_path, params: {id: '1', 
      #    #        session: {email: user.email, password: user.password}}
      #  end
      #  it 'returns_http_success' do
      #    get :edit, params: {id: user.id}
      #    expect(response).to have_http_status(:success)
      #  end
      #end

    end

    describe 'update_user' do

      context 'post_when_not_login' do
        it 'redirect_to_login_form' do
          patch :update, params: {id: '1', 
                  user: {name: "test_user_edit", email: "test@test.com", 
                          password: "password", password_confirmation: "password"}}
          expect(response).to redirect_to login_path
        end
      end

      # TODO(login operation)
      #context 'post_when_wrong_user' do
      #  before do
      #    #log_in_as(user2)
      #    
      #    #post login_path, params: {id: '2', 
      #    #       session: {email: user2.email, password: user2.password}}
      #  end
      #  it 'redirect_to_user_page' do
      #    patch :update, params: {id: '1', 
      #            user: {name: "test_user_edit", email: "test@test.com", 
      #              password: "password", password_confirmation: "password"}}
      #    expect(response).to redirect_to root_path
      #  end
      #end

      # TODO(login operation)
      #context 'post_invalid_information' do
      #  before do
      #    #log_in_as(user)
      #    
      #    #post login_path, params: {id: '1', 
      #    #        session: {email: user.email, password: user.password}}
      #  end
      #  it 'redirect_to_form' do
      #    patch :update, params: {id: user.id, 
      #            user: {name: "test_user_edit", email: "test@test.com", 
      #              password: "password", password_confirmation: "password"}}
      #    expect(response).to redirect_to edit_user_path(user)
      #  end
      #end
      
      # TODO(login operation)
      #context 'post_valid_information' do
      #  before do
      #    #log_in_as(user)
      #    
      #    #post login_path, params: {id: '1', 
      #    #        session: {email: user.email, password: user.password}}
      #  end
      #  it 'redirect_to_user_page' do
      #    patch :update, params: {id: user.id, 
      #            user: {name: "test_user_edit", email: "test@test.com", 
      #              password: "password", password_confirmation: "password"}}
      #    expect(response).to redirect_to user_path(user)
      #  end
      #end

    end

  end

end
