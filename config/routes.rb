Rails.application.routes.draw do
  get 'categories/index'

  get 'categories/show'

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

  resources :categories, only: %i[index show]
  resources :home, only: %i[index show]
  resources :orders, only: %i[index] do 
    get '/confirm/:token', to: 'orders#confirm', as: 'confirm'
  end
  resources :books, only: %i[show]
  resources :addresses, only: %i[create update]

  get 'cart', action: :index, controller: 'cart'
  post 'cart_item', action: :add_item, controller: 'cart'
  

  get 'confirmation', action: :send_order_confirmation, controller: 'checkout'

  # resources :cart, only: %i[index show]
  # get '/:token/confirm/', :to => "orders#confirm", as: 'confirm'
  # get '/checkout/', to: 'checkout#send_order_confirmation', as: 'send_order_confirmation'
end