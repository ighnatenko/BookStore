# frozen_string_literal: true

# HomeService
class HomeService
  attr_reader :slider_books, :best_seller_books

  def initialize
    @slider_books = Book.for_slider.map(&:decorate)
    @best_seller_books = Book.best_sellers.map(&:decorate)
  end
end
