class CategoriesController < ApplicationController
  def index
    redirect_to root_path, notice: 'index Catalog'
  end

  def show
    redirect_to root_path, notice: 'SHOW Catalog'
  end
end
