# frozen_string_literal: true

# UseCoupon
class UseCoupon < Rectify::Command
  def initialize(coupon)
    @coupon = coupon
  end

  def call
    return broadcast(:not_exist) unless @coupon
    return broadcast(:already_used) if @coupon.order
    broadcast(:ok)
  end
end
