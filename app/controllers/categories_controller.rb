class CategoriesController < ApplicationController
  before_action :authenticate_user!, :set_filter

  def index
    if params[:id]
      load_category
      load_books
    else
      @books = Book.by_filter(@filter, params[:page])
    end
    set_page_number
    render :show
  end

  def show
    load_category
    load_books
  end

  private

  def load_category
    @category = Category.find_by(id: params[:id])
  end

  def load_books
    @books = Book.where(category_id: params[:id]).by_filter(@filter, params[:page])
  end

  def set_page_number
    @page = if params[:page]
      params[:page].to_i + 1
    else
      2
    end
  end

  def set_filter
    @filter = Book::FILTERS.include?(params[:filter]&.to_sym) ? params[:filter] : Book::DEFAULT_FILTER
  end
end