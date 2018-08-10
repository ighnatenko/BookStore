# frozen_string_literal: true

# CategoriesController
class CategoriesController < ApplicationController
  include ApplicationHelper
  before_action :init_values, only: %i[index show]

  def index
    render :show
  end

  def show; end

  private

  def init_values
    @active_more_btn = false
    @page_number = 1
    load_books_with_category(params) if params[:id]
    load_books_without_category(params) unless params[:id]
    show_more_button?(params)
  end

  def load_books_without_category(params)
    @category = nil
    init_page_number(params)
    init_filter(params)
    @books = Book.by_filter(@filter, @page_number)
  end

  def load_books_with_category(params)
    @category = Category.find(params[:id])
    category_id = params[:id]
    init_page_number(params)
    init_filter(params)
    @books = Book.where(category_id: category_id)
                 .by_filter(@filter, @page_number)
  end

  def init_page_number(params)
    @page_number = params[:page].present? ? params[:page].to_i + 1 : 1
  end

  def init_filter(params)
    @filter = params[:filter].present? ? params[:filter] : Book::DEFAULT_FILTER
  end

  def show_more_button?(params)
    return if @books.to_a.size.zero?
    if params[:id]
      if @books.to_a.size != qunatity_book_in_category(@category.id)
        @active_more_btn = true
      end
    elsif @books.to_a.size != Book.all.count
      @active_more_btn = true
    end
  end
end
