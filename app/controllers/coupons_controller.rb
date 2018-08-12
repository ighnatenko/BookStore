# frozen_string_literal: true

# CouponsController
class CouponsController < ApplicationController
  # include Rectify::ControllerHelpers

  def create
    coupon = Coupon.find_by(code: coupon_params[:code])
    use_coupon(coupon)
  end

  private

  def use_coupon(coupon)
    UseCoupon.call(coupon) do
      on(:ok) do
        update_order_with_coupon(coupon)
        redirect_to cart_path, notice: t('coupon.added')
      end
      on(:not_exist) { redirect_to cart_path, alert: t('coupon.not_exist') }
      on(:already_used) { redirect_to cart_path, alert: t('coupon.used') }
    end
  end

  def update_order_with_coupon(coupon)
    @order = @current_order
    @order.update(coupon: coupon)
  end

  def coupon_params
    params.require(:coupon).permit(:code)
  end
end
