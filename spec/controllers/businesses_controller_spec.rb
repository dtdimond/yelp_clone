require 'spec_helper'

describe BusinessesController do
  describe 'GET new' do
    it 'sets @business to a new Business' do
      get :new
      expect(assigns(:business)).to be_a_new(Business)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    context 'with valid parameters' do
      before { post :create, business: { name: "B", description: "Words", picture_url: "/assets/pasta.jpg"}}

      it 'creates a new business' do
        expect(Business.first).not_to be_nil
      end

      it 'sets the flash success' do
        expect(flash[:success]).not_to be_blank
      end

      it 'redirects to the businesses_path' do
        expect(response).to redirect_to businesses_path
      end
    end

    context 'with invalid parameters' do
      before { post :create, business: { description: "Words", picture_url: "/assets/pasta.jpg"}}

      it 'does not create a new business' do
        expect(Business.first).to be_nil
      end

      it 'sets the flash danger' do
        expect(flash[:danger]).not_to be_blank
      end

      it 'renders the new template' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET index' do
    it 'distributes the businesses between columns equally with zero business' do
      get :index
      expect(assigns(:col1)).to be_empty
      expect(assigns(:col2)).to be_empty
      expect(assigns(:col3)).to be_empty
    end

    it 'distributes the businesses between columns equally with one business' do
      Fabricate(:business)
      get :index
      expect(assigns(:col1).count).to eq(1)
      expect(assigns(:col2)).to be_empty
      expect(assigns(:col3)).to be_empty
    end

    it 'distributes the businesses between columns equally with many business' do
      Fabricate(:business)
      Fabricate(:business)
      Fabricate(:business)
      Fabricate(:business)
      get :index
      expect(assigns(:col1).count).to eq(2)
      expect(assigns(:col2).count).to eq(1)
      expect(assigns(:col3).count).to eq(1)
    end

    it 'renders the index template' do
      Fabricate(:business)
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET show' do
    it 'sets @business' do
      business = Fabricate(:business)
      get :show, id: business.id
      expect(assigns(:business)).not_to be_nil
    end

    it 'sets @review to a new Review' do
      business = Fabricate(:business)
      get :show, id: business.id
      expect(assigns(:review)).to be_a_new Review
    end

    it 'sets @reviews to all the reviews for the business' do
      business = Fabricate(:business)
      get :show, id: business.id
      expect(assigns(:reviews)).to eq(business.reviews.all)
    end

    it 'renders the show template' do
      business = Fabricate(:business)
      get :show, id: business.id
      expect(response).to render_template :show
    end
  end
end
