class OrdersController < ApplicationController
  def index
  end

  def confirm
    order = Order.find_by_confirmation_token(params[:token])
    if order
      order.update(email_confirmed: true, completed_date: DateTime.now.to_date, completed: true)
      redirect_to root_path, notice: 'Successful order'
    else
      redirect_to root_path, alert: "Sorry. Order does not exist"
    end
  end
end
