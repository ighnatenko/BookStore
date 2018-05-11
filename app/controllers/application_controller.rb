class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_order

  private

  def set_order
    @current_order = session_order
  end

  def session_order
    order = Order.find_by(id: session[:order_id]) || Order.find_by(user: current_user)
    if order.blank? || order.state == 'in_delivery' || order.state == 'delivered'
      return new_order
    end
    order
  end

  def new_order
    order = Order.create(user_id: current_user.id, tracking_number: "R#{Time.now.strftime('%d%m%y%H%M%S')}")
    session[:order_id] = order.id
    order
  end
end