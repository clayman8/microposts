Rails.application.routes.draw do

  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'static_pages/help'
  
  resources :users do
    member do
      get :followings, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :users
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end
