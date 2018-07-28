# frozen_string_literal: true

# routes
Rails.application.routes.draw do
  mount ShoppingCart::Engine => '/shopping_cart', as: 'shopping_cart'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get '/', to: 'home#index'

  scope '/:locale', locale: /en|ru/ do
    root to: 'home#index'

    resources :customer, only: %i[index]
    put 'customer/login', to: 'customer#login'
    post 'customer/register', to: 'customer#register'

    resources :categories, only: %i[index show]
    resources :home, only: %i[index]

    resources :books, only: :show do
      resources :reviews, only: :create
    end
    resources :addresses, only: %i[index create update]
  end
end
