Rails.application.routes.draw do
  devise_for :users

  root "users#root"

  get "home/:user_id", to: "users#home", as: :user_home

  resources :users, only: [ :index ]
end
