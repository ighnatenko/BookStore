class CheckoutController < ApplicationController
  def address
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
end
