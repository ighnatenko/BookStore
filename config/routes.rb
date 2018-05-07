Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: "home#index"

  resources :checkout, only: %i[index]
  put 'checkout_address', to: 'checkout#address'
  put 'checkout_delivery', to: 'checkout#delivery'
  put 'checkout_payment', to: 'checkout#payment'
  put 'checkout_confirm', to: 'checkout#confirm'
  put 'checkout_complete', to: 'checkout#complete'

  resources :categories, only: %i[index show]
  resources :home, only: %i[index show]
  resources :orders, only: %i[index show] do 
    get '/confirm/:token', to: 'orders#confirm', as: 'confirm'
  end
  resources :books, only: %i[show]
  resources :addresses, only: %i[create update]
  resources :coupons, only: %i[create]

  get 'cart', action: :index, controller: 'cart'
  post 'cart_item', action: :add_item, controller: 'cart'
  delete 'cart', action: :destroy, controller: 'cart'
  put 'cart_decrement_item', action: :decrement, controller: 'cart'
  put 'cart_increment_item', action: :increment, controller: 'cart'

  get 'confirmation', action: :send_order_confirmation, controller: 'checkout'

  # resources :cart, only: %i[index show]
  # get '/:token/confirm/', :to => "orders#confirm", as: 'confirm'
  # get '/checkout/', to: 'checkout#send_order_confirmation', as: 'send_order_confirmation'
end