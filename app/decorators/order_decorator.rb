class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_association :book

  def sale
    coupon ? coupon.discount : 0.0
  end

  def subtotal
    sub_total = books.map(&:decorate).map{ |item| item.total_price(self) }.reduce(&:+)
    sub_total ? sub_total : 0.0
  end

  def coupon_discount
    subtotal * sale / 100
  end

  def order_total
    order_total = subtotal - coupon_discount
    order_total += delivery_id.nil? ? 0 : Delivery.find(delivery_id).price
  end
end