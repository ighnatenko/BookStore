# frozen_string_literal: true

# CheckoutDeliveryService
class CheckoutDeliveryService
  include CheckoutHelper

  attr_reader :deliveries

  def initialize(order, params = nil)
    @order = order
    @params = params
    @deliveries = Delivery.all
  end

  def show_delivery?
    address_valid?(@order)
  end

  def updated_delivery?
    if @params[:delivery].present?
      return true if @order.update(delivery_id: @params[:delivery])
    end
    false
  end

  private

  def address_valid?(order)
    billing_address = order.addresses.find_by_address_type(:billing)
    shipping_address = order.addresses.find_by_address_type(:shipping)
    !nil_or_invalid?(billing_address) && !nil_or_invalid?(shipping_address)
  end
end
