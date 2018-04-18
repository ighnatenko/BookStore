Rails.application.routes.draw do
  get 'cart/index'

  devise_for :users
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

  # root to: "home#index"
  # root to: "checkout#index"
  root to: "settings#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
