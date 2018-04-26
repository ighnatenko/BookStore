class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_order

  private
  def set_order
    @current_order = session_order
  end

  def session_order
    order = Order.find_by(id: session[:order_id]) || Order.find_by_user(current_user)
    if order.blank? || order.completed
      return new_order
    end
    order
  end

  def new_order
    order = Order.create(user: current_user)
    session[:order_id] = order.id
    order
  end
end
