class CouponsController < ApplicationController
  def create
    coupon = Coupon.find_by(code: coupon_params[:code])
    return redirect_to cart_path, alert: 'coupon.not_exist' unless coupon
    return redirect_to cart_path, alert: 'coupon.used' if coupon.order
    @order = Order.last
    @order.update(coupon: coupon)
    redirect_to cart_path, notice: 'coupon.added'
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code)
  end
end