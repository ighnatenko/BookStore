Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: "home#index"

  resources :checkout do
    collection do
      get 'index'
      put 'address'
      put 'delivery'
      put 'payment'
      put 'confirm'
      put 'complete'
    end
  end

  resources :home, only: %i[index show]
  resources :cart, only: %i[index]
  resources :orders, only: %i[index]
  resources :books, only: %i[index show]
  resources :addresses, only: %i[create update]

  get '/:token/confirm_order/', :to => "orders#confirm_order", as: 'confirm_order'
  get '/orders/', to: 'orders#send_order_confirmation', as: 'order_confirmation'
end