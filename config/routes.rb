Rails.application.routes.draw do
  devise_for :users

  root "users#root"

  get "home/:user_id", to: "users#home", as: :user_home
  get "friends", to: "users#friends", as: :user_friends
  resources :users, only: [ :index, :show ]
  resources :friendships, only: [ :create, :update ]
  resources :posts, only: [ :create ]
  resources :likes, only: [ :create ]
  resources :comments, only: [ :create ]
  resources :profiles, only: [ :update ]

  delete 'friendship/:requested_user_id/:request_sender_id', to: 'friendships#destroy', as: :cancel_request
  delete 'like/:likeable_type/:likeable_id', to: 'likes#destroy', as: :remove_like
end
