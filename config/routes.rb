Rails.application.routes.draw do
  root 'events#index'
  resources :events
  get 'static_pages/index'
  get 'static_pages/secret'
  devise_for :users
  resources :users, only: [:show] do
    member do
      get :edit_profile
      put :update_profile
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
