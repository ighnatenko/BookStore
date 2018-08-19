# frozen_string_literal: true

# ApplicationHelper
module ApplicationHelper
  def categories
    Category.all
  end

  def quantity_book_in_cart
    return 0 unless @current_order.in_progress?
    @current_order.books.count
  end

  def qunatity_book_in_category(id)
    Book.where(category_id: id).count
  end
end
