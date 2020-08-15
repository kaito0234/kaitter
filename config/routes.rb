Rails.application.routes.draw do

  root 'static_pages#home'
  resources :events, only:[ :create, :update]
  get 'likes/create'
  get 'likes/destroy'
  get  '/help',    to: 'static_pages#help'
  get  '/icon',   to: 'static_pages#icon'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/search', to: 'microposts#search'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    resources :events
    resources :conditions do
      collection do
        get :index_ago1
        get :index_ago2
        get :index_ago3
        get :index_ago4
        get :index_ago5
        get :index_ago6
        get :index_ago7
        get :index_week
        get :index_1week
        get :index_2week
        get :index_3week
        get :index_4week
        get :index_month
        get :index_1month
        get :index_2month
        get :index_3month
        get :index_4month
        get :index_5month
        get :index_6month
      end
    end
    resources :meetings do
      collection do
        get :index_week
      end
    end
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
