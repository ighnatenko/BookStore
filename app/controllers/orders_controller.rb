# frozen_string_literal: true

# OrdersController
class OrdersController < ApplicationController
  authorize_resource

  def index
    @orders = current_user.orders.newest
    @orders = @orders.by_state(params[:state].to_sym) if valid_state?

    if @orders.to_a.size.zero?
      return redirect_to root_path, notice: t('orders.do_not_have_order')
    end
    @orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    order = Order.find_by_confirmation_token(params[:token])
    if order
      order.update(email_confirmed: true,
                   completed_date: DateTime.now.to_date,
                   state: 'delivered')
      redirect_to root_path, notice: t('orders.successful')
    else
      redirect_to root_path, alert: t('orders.not_exist')
    end
  end

  private

  def valid_state?
    Order.aasm_states.include?(params[:state]&.to_sym)
  end
end
