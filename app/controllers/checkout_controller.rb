# frozen_string_literal: true

class CheckoutController < ApplicationController
  include CheckoutParams
  include Wicked::Wizard
  before_action :authenticate_user!, :set_order

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    redirect_to root_path if @order.books.count == 0
    case step
    when :address  then show_address
    when :delivery then show_delivery
    when :payment  then show_payment
    when :confirm  then show_confirm
    when :complete then show_complete
    end
    render_wizard unless performed?
  end

  def update
    case step
    when :address  then update_address
    when :delivery then update_delivery
    when :payment  then update_payment
    when :confirm  then update_confirm
    when :complete then update_complete
    end
    redirect_to_valid_step
  end

  def show_address
    @order.update(user: current_user) if @order.user_id.nil?
    @billing_address = current_user.addresses.find_by_address_type(:billing)
    @shipping_address = current_user.addresses.find_by_address_type(:shipping)
    
    @billing_address ||= @order.addresses.find_by_address_type(:billing)
    @shipping_address ||= @order.addresses.find_by_address_type(:shipping)
  end

  def show_delivery
    return jump_to(valid_step) unless address_valid?(@order)
    @deliveries = Delivery.all
  end

  def show_payment
    return jump_to(valid_step) if @order.delivery.nil?
    @credit_card = CreditCard.find_by(order_id: current_user.orders.first.id)
    @credit_card ||= @order.credit_card
    @credit_card = CreditCard.new if nil_or_invalid?(@credit_card)
  end

  def show_confirm
    return jump_to(valid_step) if nil_or_invalid?(current_user.orders.last.credit_card)
  end

  def show_complete
    return jump_to(valid_step) if nil_or_invalid?(current_user.orders.last.credit_card)
    @shipping_address = @order.addresses.find_by_address_type(:shipping)
    @order.deliver
  end

  private

  def redirect_to_valid_step
    if nil_or_invalid?(current_user.orders.last.credit_card)
      redirect_to next_wizard_path unless performed?
    else
      if step == :confirm
        jump_to(:complete)
      elsif previous_step == :address || :delivery || :payment
        jump_to(:confirm)
      end
      render_wizard unless performed?
    end
  end

  def valid_step
    case true
    when nil_or_invalid?(current_user.orders.last.addresses.find_by_address_type(:billing)) ||
      nil_or_invalid?(current_user.orders.last.addresses.find_by_address_type(:shipping)) then :address
    when nil_or_invalid?(current_user.orders.last.delivery) then :delivery
    when nil_or_invalid?(current_user.orders.last.credit_card) then :payment
    else :payment
    end
  end

  def update_address
    set_address_for_order(@order)
    render_wizard unless @billing_address.valid? && @shipping_address.valid?
  end

  def update_delivery
    @deliveries = Delivery.all
    render_wizard unless params[:delivery].present?
    render_wizard unless @order.update(delivery_id: params[:delivery])
  end

  def update_payment
    @credit_card = @order.credit_card
    @credit_card ? @credit_card.update(credit_card_params) : @credit_card = @order.create_credit_card(credit_card_params)
    render_wizard unless credit_card_valid?(@order)
  end

  def update_confirm; end

  def update_complete
    redirect_to root_path
  end

  def set_order
    @order = @current_order
  end

  def set_address_for_order(order)
    if params[:billing_address].present? && params[:shipping_address].present?
      order.update(use_billing: params[:use_billing] || false)
      @billing_address = update_address_with_type(order, :billing, billing_address_params)

      shipping_params = params[:use_billing] ? billing_address_params : shipping_address_params
      shipping_params[:address_type] = :shipping
      @shipping_address = update_address_with_type(order, :shipping, shipping_params)
    end
  end

  def update_address_with_type(order, address_type, params)
    address = @order.addresses.find_by_address_type(address_type)
    address ? address.update(params) : address = order.addresses.create(params)
    address
  end

  def address_valid?(order)
    billing_address = order.addresses.find_by_address_type(:billing)
    shipping_address = order.addresses.find_by_address_type(:shipping)
    !(nil_or_invalid?(billing_address) || nil_or_invalid?(shipping_address))
  end

  def credit_card_valid?(order)
    !nil_or_invalid?(order.credit_card)
  end

  def nil_or_invalid?(object)
    object.nil? || object.invalid?
  end
end
