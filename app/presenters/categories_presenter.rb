# frozen_string_literal: true

# CategoriesPresenter
class CategoriesPresenter < Rectify::Presenter
  attribute :params

  def page_number
    params[:page].present? ? params[:page].to_i + 1 : 1
  end

  def filter
    params[:filter].present? ? params[:filter] : Book::DEFAULT_FILTER
  end
end
