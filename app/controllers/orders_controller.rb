class OrdersController < ApplicationController
  load_and_authorize_resource
  
  def index
    @orders = current_user.orders.newest
    @orders = @orders.by_state(params[:state].to_sym) if valid_state?
  end

  def show
  end

  def confirm
    order = Order.find_by_confirmation_token(params[:token])
    if order
      order.update(email_confirmed: true, completed_date: DateTime.now.to_date, state: "delivered")
      redirect_to root_path, notice: 'Successful order'
    else
      redirect_to root_path, alert: "Sorry. Order does not exist"
    end
  end

  private

  def valid_state?
    Order.aasm_states.include?(params[:state]&.to_sym)
  end
end