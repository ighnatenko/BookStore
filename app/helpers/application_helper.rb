module ApplicationHelper
  def categories
    Category.all
  end

  def quantity_book_in_cart
    @current_order.books.count
  end
end
