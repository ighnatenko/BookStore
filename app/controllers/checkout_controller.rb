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

    if address_valid?(@order)
      @order = Order.last
      @deliveries = Delivery.all
      render :delivery
    else 
      render :address
    end
  end

  def delivery
    @order = Order.last
    @deliveries = Delivery.all
    if update_delivery(@order, params) && params[:delivery].present?
      @credit_card = @order.credit_card
      if nil_or_invalid?(@credit_card)
        @credit_card = CreditCard.new
      end
      render :payment
    else
      render :delivery, alert: 'Выберите способ оплаты'
    end
  end

  def payment
    @order = Order.last
    @credit_card = update_credit_card(@order, credit_card_params)
    if credit_card_valid?(@order)
      render :confirm
    else
      render :payment
    end
  end

  def confirm
    render 'confirm'
  end

  def complete
    render 'complete'
  end

  def send_order_confirmation
    order = Order.last
    order.set_confirmation_token
    order.save(validate: false)
    OrderMailer.order_confirmation(order).deliver_now
    redirect_to root_path, notice: "Please confirm your order to continue"
  end

  private
  
  def address_valid?(order)
    billing_address = order.addresses.find_by_address_type(:billing)
    shipping_address = order.addresses.find_by_address_type(:shipping)
    (nil_or_invalid?(billing_address) || nil_or_invalid?(shipping_address)) ? false : true
  end

  def credit_card_valid?(order)
    !nil_or_invalid?(order.credit_card)
  end

  def nil_or_invalid?(object)
    object.nil? || object.invalid?
  end

  def billing_address_params
    params.require(:billing_address).permit(:firstname, :lastname, :address,
     :city, :zipcode, :country, :phone, :address_type)
  end

  def shipping_address_params
    params.require(:shipping_address).permit(:firstname, :lastname, :address,
     :city, :zipcode, :country, :phone, :address_type)
  end

  def credit_card_params
    params.require(:credit_card).permit(:number, :cvv, :expiration_date, :card_name)
  end

  def update_address(order, address_type, params)
    address = order.addresses.find_by_address_type(address_type)
    address ? address.update(params) : address = order.addresses.create(params)
    address
  end

  def update_credit_card(order, params)
    credit_card = order.credit_card
    credit_card ? credit_card.update(params) : credit_card = order.create_credit_card(params)
    credit_card
  end

  def update_delivery(order, params)
    order.update(delivery_id: params[:delivery])
  end
end