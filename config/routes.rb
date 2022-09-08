Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'ideas#index'

  resources :ideas do
    resources :reviews, only: [:create, :destroy]
    resources :likes, shallow: true, only: [:create, :destroy]
    
  end
  resources :users, only:[:new, :create]
  resource :session, only:[:new, :create, :destroy]
end
