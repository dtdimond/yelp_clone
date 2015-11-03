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
end
