# frozen_string_literal: true

# CheckoutPaymentService
class CheckoutPaymentService
  include CheckoutHelper

  attr_reader :credit_card

  def initialize(order, params = nil, current_user = nil)
    @order = order
    @params = params
    init_credit_card(current_user) unless current_user.nil?
  end

  def call
    @credit_card ? @credit_card.update(credit_card_params) :
    @credit_card = @order.create_credit_card(credit_card_params)
    self
  end

  private

  def init_credit_card(current_user)
    @credit_card = CreditCard.find_by(order_id: current_user.orders.first.id)
    @credit_card ||= @order.credit_card
    @credit_card = CreditCard.new if nil_or_invalid?(@credit_card)
  end

  def credit_card_params
    @params.require(:credit_card)
           .permit(:number, :cvv, :expiration_date, :card_name)
  end
end
