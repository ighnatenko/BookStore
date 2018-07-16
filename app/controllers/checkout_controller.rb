# frozen_string_literal: true

# CheckoutController
class CheckoutController < ApplicationController
  include Wicked::Wizard
  include CheckoutHelper
  before_action :authenticate_user!, :set_order

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    redirect_to root_path if @order.books.count.zero?
    case step
    when :address then show_address
    when :delivery then show_delivery
    when :payment then show_payment
    when :confirm  then show_confirm
    when :complete then show_complete
    end
    render_wizard unless performed?
  end

  def update
    case step
    when :address then update_address
    when :delivery then update_delivery
    when :payment then update_payment
    when :confirm  then update_confirm
    when :complete then update_complete
    end
    redirect_to_valid_step
  end

  private

  def show_confirm
    return jump_to(valid_step) if nil_or_invalid?(current_user.orders.last.credit_card)
  end

  def show_complete
    return jump_to(valid_step) if nil_or_invalid?(current_user.orders.last.credit_card)
    @shipping_address = @order.addresses.find_by_address_type(:shipping)
    @order.deliver
  end

  def show_address
    @address_service = CheckoutAddressService.new(@order, nil, current_user)
  end

  def show_delivery
    @delivery_service = CheckoutDeliveryService.new(@order)
    jump_to(valid_step) unless @delivery_service.show_delivery?
  end

  def show_payment
    @payment_service = CheckoutPaymentService.new(@order, nil, current_user)
    jump_to(valid_step) unless @payment_service.show_payment?
  end

  def update_address
    @address_service = CheckoutAddressService.new(@order, params)
    render_wizard unless @address_service.updated_address?
  end

  def update_delivery
    @delivery_service = CheckoutDeliveryService.new(@order, params)
    render_wizard unless @delivery_service.updated_delivery?
  end

  def update_payment
    @payment_service = CheckoutPaymentService.new(@order, params)
    @payment_service.update
    render_wizard unless @payment_service.credit_card_valid?(@order)
  end

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

  def update_confirm; end

  def update_complete
    redirect_to root_path
  end

  def set_order
    @order = @current_order
  end
end
