class BookDecorator < Draper::Decorator
  delegate_all

  def dimensions
    ["H: #{height}\"", "W: #{width}\"", "D: #{depth}\""].join(' x ')
  end

  def root_image
    images.any? ? images.first.url : 'default'
  end

  def authors_names
    authors.map { |author| author.decorate.full_name }.join(', ')
  end

  def quantity_in_cart(order)
    Position.find_by(order_id: order.id, book_id: id).quantity
  end

  def total_price(order)
    quantity_in_cart(order) * price
  end
end