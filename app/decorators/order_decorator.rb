class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_association :book

  def sale
    coupon ? coupon.discount : 0.0
  end

  def subtotal
    books.map(&:decorate).map{ |item| item.total_price(self) }.reduce(&:+)
  end

  def coupon_discount
    subtotal * sale / 100
  end

  def order_total
    subtotal - coupon_discount
  end
end