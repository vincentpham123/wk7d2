Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "sessions#new"

  resources :users, only: [:create, :new,:show]
  resource :session, only: [:create, :new, :destroy]
end
