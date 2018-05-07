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

  def quantity_in_cart
    Position.find_by(book_id: self.id).quantity
  end

  def total_price
    quantity_in_cart * price
  end
end