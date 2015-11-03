class ReviewsController < ApplicationController
  before_action :require_user, except: [:index]

  def create
    review = Review.new(description: params[:review][:description],
                        business_id: params[:review][:business_id],
                        user_id: current_user.id)

    if review.save
      flash[:success] = "New review created!"
    else
      flash[:danger] = "There was a problem creating the review"
    end

    business = Business.find(params[:review][:business_id])
    redirect_to business_path(business)
  end

  def index
    @reviews = Review.all.order(:created_at).reverse.first(6)
  end
end