# frozen_string_literal: true

# CategoriesController
class CategoriesController < ApplicationController
  include ApplicationHelper
  include Rectify::ControllerHelpers
  before_action :init_values, only: %i[index show]

  def index
    render :show
  end

  def show; end

  private

  def init_values
    @present = CategoriesPresenter.new(params: params)
    load_books_with_category(params) if params[:id]
    load_books_without_category unless params[:id]
    @active_more_btn = show_more_button?(params)
  end

  def load_books_without_category
    @category = nil
    @books = Book.by_filter(@present.filter, @present.page_number)
  end

  def load_books_with_category(params)
    @category = Category.find(params[:id])
    category_id = params[:id]
    @books = Book.where(category_id: category_id)
                 .by_filter(@present.filter, @present.page_number)
  end

  def show_more_button?(params)
    return false unless @books.exists?

    if params[:id]
      return true if @books.to_a.size != qunatity_book_in_category(@category.id)
      return false
    elsif @books.to_a.size != Book.all.count
      return true
    end
    false
  end
end
