# frozen_string_literal: true

# Locale
module Locale
  extend ActiveSupport::Concern

  included do
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def default_url_options(*)
      { locale: I18n.locale }
    end
  end
end
