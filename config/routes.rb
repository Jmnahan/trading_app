Rails.application.routes.draw do
  root 'pages#landing'
  devise_for :users

  scope "home" do
    resources :users
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
