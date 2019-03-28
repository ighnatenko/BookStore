# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  include Locale
  protect_from_forgery with: :exception
  before_action :present_order, :set_locale

  [CanCan::AccessDenied, ActiveRecord::RecordNotFound,
   ActionController::RoutingError].each do |error|
    rescue_from error do |exception|
      redirect_to main_app.root_path, alert: exception.message
    end
  end

  def present_order
    @last_order ||= order_from_current_user || order_from_session
    return unless @last_order.nil? || !@last_order.in_progress?
    @last_order = new_order
  end

  def current_order
    @last_order
  end

  private

  def order_from_current_user
    order = current_user&.orders&.find_by(state: 'in_progress')
    session[:order_id] = order.id if order
    order
  end

  def order_from_session
    ShoppingCart::Order.find_by(id: session[:order_id])
  end

  def new_order
    tracking_number = "R#{Time.now.strftime('%d%m%y%H%M%S')}"
    order = ShoppingCart::Order.create(user: current_user, tracking_number: tracking_number)
    session[:order_id] = order.id
    order
  end
end
