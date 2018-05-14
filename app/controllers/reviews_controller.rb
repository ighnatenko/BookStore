class ReviewsController < ApplicationController
  load_and_authorize_resource :book

  def create
    rating = params[:rating].to_i
    review = Review.create(rating: rating, description: review_params[:description],
                           book_id: params[:book_id], user_id: current_user.id)
    review.errors.any? flash[:alert] = t('review.failure.create') : flash[:notice] = t('review.successful.create')
    redirect_to @book
  end

  private

  def review_params
    params.require(:review).permit(:description)
  end
end
