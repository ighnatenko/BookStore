# frozen_string_literal: true

# CouponsController
class CouponsController < ApplicationController
  def create
    UseCoupon.call(coupon_params, @current_order) do
      on(:ok) { redirect_to cart_path, notice: t('coupon.added') }
      on(:not_exist) { redirect_to cart_path, alert: t('coupon.not_exist') }
      on(:already_used) { redirect_to cart_path, alert: t('coupon.used') }
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code)
  end
end
