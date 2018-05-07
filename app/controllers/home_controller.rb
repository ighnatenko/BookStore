class HomeController < ApplicationController
  def index
    @slider_books = Book.for_slider.map(&:decorate)
    @best_seller_books = Book.best_sellers.map(&:decorate)
  end
end