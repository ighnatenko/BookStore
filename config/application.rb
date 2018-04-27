require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module BookSrore
  class Application < Rails::Application
    config.load_defaults 5.1
  end

  # ActionMailer::Base.smtp_settings = {
  #   :user_name => ENV['SENDGRID_USERNAME'],
  #   :password => ENV['SENDGRID_PASSWORD'],
  #   :domain => 'herokuapp.com',
  #   :address => 'smtp.sendgrid.net',
  #   :port => 587,
  #   :authentication => :plain,
  #   :enable_starttls_auto => true
  # }
end