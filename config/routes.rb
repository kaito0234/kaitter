Rails.application.routes.draw do

  get 'likes/create'
  get 'likes/destroy'

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/icon',   to: 'static_pages#icon'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/show_microposts', to: 'microposts#show_microposts'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts, only:[:create, :destroy, :show] do
    resource :likes, only:[:create, :destroy]
    resources :comments, only:[:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :notices, only: [:index]
  resources :updates
end
