# frozen_string_literal: true

RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
  config.parent_controller = 'ApplicationController'
  config.authorize_with :cancan
  config.actions do
    dashboard
    index
    new
    bulk_delete { except %i[Address CreditCard Position User Order] }
    show
    edit { except %i[Address CreditCard Position Order] }
    delete { except %i[Address CreditCard Position User Order] }
  end

  config.included_models = [Address, Author, Book, Category, Position, Order,
                            Coupon, Delivery, Image, User, CreditCard]

  config.model Address do
    %i[firstname lastname address zipcode
       city country phone address_type].each do |field|
      field field
    end
  end

  config.model Book do
    field :title
    field :description
    field :price
  end

  config.model Delivery do
    exclude_fields :orders
  end

  [Position, Author, Category, CreditCard].each do |model|
    config.model model do
      exclude_fields :created_at
      exclude_fields :updated_at
    end
  end

  config.model CreditCard do
    exclude_fields :cardable_type
  end

  config.model Coupon do
    field :code
    field :discount
  end

  config.model User do
    field :email
    field :created_at
    field :admin
    edit { exclude_fields :created_at }
  end
end
