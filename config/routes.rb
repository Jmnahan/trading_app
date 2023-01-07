Rails.application.routes.draw do
  root 'pages#landing'
  devise_for :users
  
  scope 'home' do
    resources :users
    get '/pending', to: 'users#pending', as: 'admin_pending'
    patch '/users/:id/approve', to: 'users#approve', as: 'admin_approve'
    get '/users/:id/portfolio', to: 'users#portfolio', as: 'user_portfolio'
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
