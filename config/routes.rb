Rails.application.routes.draw do

  resources :contacts
  resources :jobs
  resources :users

  post "/login", to: "sessions#create"
  post "/logout", to: "sessions#destroy"
end
