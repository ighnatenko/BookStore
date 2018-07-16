# frozen_string_literal: true

Rails.application.routes.draw do
  get 'customer/create'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  root to: 'home#index'

  get 'cart', to: 'cart#index'
  delete 'cart', to: 'cart#destroy'
  post 'cart_item', to: 'cart#add_item'
  put 'cart_decrement_item', to: 'cart#decrement'
  put 'cart_increment_item', to: 'cart#increment'

  resources :customer, only: %i[index]
  put 'customer/login', to: 'customer#login'
  post 'customer/register', to: 'customer#register'

  resources :checkout
  resources :categories, only: %i[index show]
  resources :home, only: %i[index]
  resources :orders, only: %i[index show] do
    get '/confirm/:token', to: 'orders#confirm', as: 'confirm'
  end
  resources :books, only: :show do
    resources :reviews, only: :create
  end
  resources :addresses, only: %i[create update]
  resources :coupons, only: :create
end
