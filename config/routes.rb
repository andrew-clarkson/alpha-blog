Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'blog#home'
  get 'about', to: 'blog#about'
  #resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  # above is same as below, exposes all routes
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end