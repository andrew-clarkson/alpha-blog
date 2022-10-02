Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'blog#home'
  get 'about', to: 'blog#about'
  #resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  # above is same as below, exposes all routes
  resources :articles
end