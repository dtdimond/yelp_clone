require 'spec_helper'

describe ReviewsController do
  describe 'POST create' do
    context 'with valid params' do
      let(:business) { Fabricate(:business) }
      before do
        set_current_user
        post :create, review: { description: "text", business_id: business.id }
      end

      it 'creates a new review' do
        expect(Review.count).to eq(1)
      end

      it 'sets the current_user to be the reviews user' do
        expect(Review.first.user).to eq(current_user)
      end

      it 'sets the flash success' do
        expect(flash[:success]).not_to be_blank
      end

      it 'redirects to the business_path' do
        expect(response).to redirect_to business_path(business)
      end
    end

    context 'with invalid params' do
      let(:business) { Fabricate(:business) }
      before do
        set_current_user
        post :create, review: { business_id: business.id }
      end

      it 'does not create a new review' do
        expect(Review.count).to eq(0)
      end

      it 'sets the flash danger' do
        expect(flash[:danger]).not_to be_blank
      end

      it 'redirects to the business_path' do
        expect(response).to redirect_to business_path(business)
      end
    end

    context 'without a user logged in' do
      let(:business) { Fabricate(:business) }
      before { post :create, review: { description: "text", business_id: business.id } }

      it 'sets the flash danger' do
        expect(flash[:danger]).not_to be_blank
      end

      it 'redirects to the login_path' do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET index' do
    it 'sets the @reviews to [] if there are no reviews' do
      get :index
      expect(assigns(:reviews)).to be_empty
    end

    it 'sets the @reviews to [review] if there is one review' do
      Fabricate(:review)
      get :index
      expect(assigns(:reviews)).to eq(Review.all)
    end

    it 'sets the @reviews to all reviews if there are 6 reviews' do
      Fabricate(:review)
      Fabricate(:review)
      Fabricate(:review)
      Fabricate(:review)
      Fabricate(:review)
      Fabricate(:review)
      get :index
      expect(assigns(:reviews)).to eq(Review.all.order(:created_at).reverse)
    end

    it 'sets the @reviews to the most recent 6 reviews if there are more than 6' do
      r1 = Fabricate(:review, created_at: 1.minutes.ago)
      r2 = Fabricate(:review, created_at: 2.minutes.ago)
      r3 = Fabricate(:review, created_at: 3.minutes.ago)
      r4 = Fabricate(:review, created_at: 4.minutes.ago)
      r5 = Fabricate(:review, created_at: 5.minutes.ago)
      r6 = Fabricate(:review, created_at: 9.minutes.ago)
      r7 = Fabricate(:review, created_at: 6.minutes.ago)
      get :index
      expect(assigns(:reviews)).to eq([r1, r2, r3, r4, r5, r7])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end
  end
end
