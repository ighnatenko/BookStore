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
  resources :orders, only: %i[index] do 
    get '/confirm/:token', to: 'orders#confirm', as: 'confirm'
  end
  resources :books, only: %i[index show]
  resources :addresses, only: %i[create update]

  get 'confirmation', action: :send_order_confirmation, controller: 'checkout'


  # get '/:token/confirm/', :to => "orders#confirm", as: 'confirm'
  # get '/checkout/', to: 'checkout#send_order_confirmation', as: 'send_order_confirmation'
end