# frozen_string_literal: true

# CategoriesController
class CategoriesController < ApplicationController
  before_action :load_categories

  def index
    render :show
  end

  def show; end

  private

  def load_categories
    @category_service = CategoryService.new.call(params)
  end
end
