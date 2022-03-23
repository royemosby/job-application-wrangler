Rails.application.routes.draw do
  resources :contacts
  resources :jobs
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create", as: "username_pw_login"
  get "/auth/github/callback" => "sessions#create"
  post "/logout", to: "session#destroy"
  
  root "users#index"
end
