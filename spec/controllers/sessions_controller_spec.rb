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
    it 'sets the session[:user_id] if user found and authenticated'
    it 'sets the flash success if user found and authenticated'
    it 'redirects to the home_path if user found and authenticated'

    it 'redirects to the login_path if user found and not authenticated'
    it 'sets the flash danger if user found and not authenticated'

    it 'redirects to the login_path if user not found'
    it 'sets the flash danger if user not found'

  end
end

