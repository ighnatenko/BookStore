# frozen_string_literal: true

# OrderMailer
class OrderMailer < ApplicationMailer
  def order_confirmation(user, order)
    locale = I18n.locale
    @url = order_confirm_url(locale, order, order.confirmation_token)
    mail(to: user.email, subject: 'Please confirm your order to continue')
  end
end
