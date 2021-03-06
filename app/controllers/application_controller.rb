# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  include CurrentOrder
  include Locale
  protect_from_forgery with: :exception
  before_action :present_order, :set_locale

  [CanCan::AccessDenied, ActiveRecord::RecordNotFound,
   ActionController::RoutingError].each do |error|
    rescue_from error do |exception|
      redirect_to main_app.root_path, alert: exception.message
    end
  end
end
