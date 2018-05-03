class CategoriesController < ApplicationController
  before_action :set_filter

  def index
    if params[:id]
      @category = Category.find_by(id: params[:id])
      @books = Book.where(category_id: params[:id]).by_filter(@filter, params[:page])
      if params[:page]
        @page = params[:page].to_i + 1
      else
        @page = 2
      end
    else
      @books = Book.by_filter(@filter, params[:page])
      if params[:page]
        @page = params[:page].to_i + 1
      else
        @page = 2
      end
      
    end
    render :show
  end

  def show
    @category = Category.find_by(id: params[:id])
    @books = Book.where(category_id: params[:id]).by_filter(@filter, params[:page])
  end

  private

  def set_filter
    @filter = Book::FILTERS.include?(params[:filter]&.to_sym) ? params[:filter] : Book::DEFAULT_FILTER
  end
end
