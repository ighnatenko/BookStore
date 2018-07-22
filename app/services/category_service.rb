# frozen_string_literal: true

# CategoryService
class CategoryService
  include ApplicationHelper
  attr_reader :category, :page_number, :filter, :books, :active_more_btn

  def initialize
    @active_more_btn = false
  end

  def call(params)
    @page_number = 1
    load_books_with_category(params) if params[:id]
    load_books_without_category(params) unless params[:id]
    show_more_button?(params)
    self
  end

  private

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
