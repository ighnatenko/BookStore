Rails.application.routes.draw do
  get 'cart/index'

  devise_for :users
  get 'books/index'
  get 'books/show'

  get 'orders/index'

  get 'settings/index'

  get 'checkout/address'
  get 'checkout/delivery'
  get 'checkout/payment'
  get 'checkout/confirm'
  get 'checkout/complete'

  get 'home/index'

  # root to: "home#index"
  root to: "checkout#address"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
