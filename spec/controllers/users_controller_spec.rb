require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it 'sets @user to a new User' do
      get :new
      expect(assigns(:user)).to be_a_new User
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      before { post :create, user: {email: "v@t.com", password: "good", full_name: "Name" } }

      it 'creates a new user if params validate' do
        expect(User.first).not_to be_nil
      end

      it 'sets the session[:user_id] to the new user.id if params validate' do
        expect(session[:user_id]).to eq(User.first.id)
      end

      it 'sets the flash success if params validate' do
        expect(flash[:success]).not_to be_blank
      end

      it 'redirects to the home_path if params validate' do
        expect(response).to redirect_to home_path
      end
    end

    it 'does not create a enw user if params do not validate'
    it 'does not set the session[:user_id] if params do not validate'
    it 'sets the flash danger if params do not validate'
    it 'renders :new if the params do not validate'
  end
end

