Rails.application.routes.draw do
  root 'pages#landing'
  devise_for :users

  get '/market', to: 'pages#market', as: 'pages_market'
  
  scope 'home' do
    resources :users
    get '/pending', to: 'users#pending', as: 'admin_pending'
    patch '/users/:id/approve', to: 'users#approve', as: 'admin_approve'
    get '/users/:id/transaction', to: 'users#transaction', as: 'user_transaction'
  end

  resources :stocks do
    resources :orders
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
