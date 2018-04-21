Rails.application.routes.draw do
  get 'cart/index'

  get 'books/index'
  get 'books/show'

  get 'orders/index'

  post 'settings/index'

  get 'checkout/index'
  put 'checkout/address'
  put 'checkout/delivery'
  put 'checkout/payment'
  put 'checkout/confirm'
  put 'checkout/complete'

  get 'home/index'
  
  resources :addresses, only: %i[create update]

  root to: "settings#index"

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

end
