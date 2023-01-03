Rails.application.routes.draw do
  root 'pages#landing'
  devise_for :users

  scope 'home' do
    resources :users
    get '/pending', to: 'users#pending', as: 'admin_pending'
    patch '/users/:id/approve', to: 'users#approve', as: 'admin_approve'
  end
  scope "admin" do
    get '/notifications', to: "users#notifications", as: 'notifications'
    put '/users/:id/approve', to:"users#approve_user", as: 'approve_user' 
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
