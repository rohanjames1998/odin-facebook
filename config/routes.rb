Rails.application.routes.draw do
  devise_for :users

  root "users#root"

  get "home/:user_id", to: "users#home", as: :user_home

  resources :users, only: [ :index ]
  resources :friendships, only: [ :create ]

  delete 'friendship/:requested_user_id/request_sender_id', to: 'friendships#destroy', as: :cancel_request
end
