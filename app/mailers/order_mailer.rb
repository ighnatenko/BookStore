class OrderMailer < ApplicationMailer
  def order_confirmation(order)
    @url = order_confirm_url(order, order.confirmation_token)
    mail(to: "ighnatenko@meta.ua", subject: "Confirm your order")
  end
end
