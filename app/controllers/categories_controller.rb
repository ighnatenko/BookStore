# frozen_string_literal: true

# CategoriesController
class CategoriesController < ApplicationController
  before_action :init_values, only: %i[index show]

  def index
    render :show
  end

  def show; end

  private

  def init_values
    @presenter = CategoriesPresenter.new(params: params)
    @category = params[:id] ? Category.find(params[:id]) : nil
    @books = if @category
               books_with_category(@category)
             else
               books_without_category
             end
    @presenter.books = @books
    @presenter.category = @category
  end

  def books_without_category
    Book.by_filter(@presenter.filter, @presenter.page_number)
  end

  def books_with_category(category)
    Book.where(category_id: category.id)
        .by_filter(@presenter.filter, @presenter.page_number)
  end
end
