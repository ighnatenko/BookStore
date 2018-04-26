class OrderMailer < ApplicationMailer
  def order_confirmation(order)
    @url = order_verify_url(order, order.confirmation_token)
    mail(to: "ighnatenko@meta.ua", subject: "order.confirm_email_subject")
  end
end
