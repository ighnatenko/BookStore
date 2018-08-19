# frozen_string_literal: true

# ReviewsController
class ReviewsController < ApplicationController
  load_and_authorize_resource :book

  def create
    rating = params[:rating]&.to_i
    review = Review.create(rating: rating,
                           description: review_params[:description],
                           book_id: params[:book_id],
                           user_id: current_user.id)
    show_flash(review.errors)
    redirect_to @book
  end

  private

  def show_flash(errors)
    if errors.any?
      flash[:alert] = t('review.failure.create')
    else
      flash[:notice] = t('review.successful.create')
    end
  end

  def review_params
    params.require(:review).permit(:description)
  end
end
