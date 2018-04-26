class CheckoutController < ApplicationController
  def index
    @order = Order.last
    @billing_address = @order.addresses.find_by_address_type(:billing)
    @shipping_address = @order.addresses.find_by_address_type(:shipping)
    render 'address'
  end

  def address
    @order = Order.last
    @order.update(use_billing: params[:use_billing] || false)
    @billing_address = update_address(@order, :billing, billing_address_params)

    shipping_params = 
    params[:use_billing] ? billing_address_params : shipping_address_params
    shipping_params[:address_type] = :shipping
    @shipping_address = update_address(@order, :shipping, shipping_params)

    render 'address'
  end

  def delivery
    render 'delivery'
  end

  def payment
    render 'payment'
  end

  def confirm
    render 'confirm'
  end

  def complete
    render 'complete'
  end

  def confirm_order
    order = Order.find_by_confirmation_token(params[:token])
    if order
      order.update(email_confirmed: true, completed_date: DateTime.now.to_date)
      redirect_to root_path, notice: 'Successful order'
    else
      redirect_to root_url, alert: "Sorry. Order does not exist"
    end
  end

  def send_order_confirmation
    order.set_confirmation_token
    order.save(validate: false)
    OrderMailer.order_confirmation(@user).deliver_now
    redirect_to root_path, notice: "Please confirm your order to continue"
  end

  private

  def billing_address_params
    params.require(:billing_address).permit(:firstname, :lastname, :address,
     :city, :zipcode, :country, :phone, :address_type)
  end

  def shipping_address_params
    params.require(:shipping_address).permit(:firstname, :lastname, :address,
     :city, :zipcode, :country, :phone, :address_type)
  end

  def update_address(order, address_type, params)
    address = @order.addresses.find_by_address_type(address_type)
    address ? address.update(params) : address = order.addresses.create(params)
    address
  end
end
