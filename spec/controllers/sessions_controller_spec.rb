require 'spec_helper'

describe SessionsController do
  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end

    it 'redirects to the home_path if already logged in' do
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe 'POST create' do
    context 'with correct user and password' do
      let(:user) { Fabricate(:user) }
      before { post :create, user: { email: user.email, password: user.password } }

      it 'sets the session[:user_id]' do
        expect(session[:user_id]).to eq(user.id)
      end

      it 'sets the flash success' do
        expect(flash[:success]).not_to be_blank
      end

      it 'redirects to the home_path' do
        expect(response).to redirect_to home_path
      end
    end

    context 'with correct user and incorrect password' do
      let(:user) { Fabricate(:user) }
      before { post :create, user: { email: user.email, password: "wrongpassword" } }

      it 'redirects to the login_path' do
        expect(response).to redirect_to login_path
      end

      it 'sets the flash danger' do
        expect(flash[:danger]).not_to be_blank
      end
    end

    context 'with incorrect user' do
      let(:user) { Fabricate(:user) }
      before { post :create, user: { email: "wrongemail", password: user.password } }

      it 'redirects to the login_path' do
        expect(response).to redirect_to login_path
      end
      it 'sets the flash danger' do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe 'GET destroy' do
    before { get :destroy }

    it 'clears the session[:user_id]' do
      expect(session[:user_id]).to be_nil
    end

    it 'sets the flash[:success]' do
      expect(flash[:success]).not_to be_blank
    end

    it 'redirects to the root_path' do
      expect(response).to redirect_to root_path
    end
  end
end

