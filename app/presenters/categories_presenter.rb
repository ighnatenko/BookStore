# frozen_string_literal: true

# CategoriesPresenter
class CategoriesPresenter < Rectify::Presenter
  include ApplicationHelper
  attribute :params
  attribute :books, Book
  attribute :category, Category

  def page_number
    params[:page].present? ? params[:page].to_i + 1 : 1
  end

  def filter
    params[:filter].present? ? params[:filter] : Book::DEFAULT_FILTER
  end

  def active_more_btn
    return books.returns_count_sum.count != Book.count unless params[:id]
    books.returns_count_sum.count != qunatity_book_in_category(category.id)
  end
end
