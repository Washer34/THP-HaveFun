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

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancer', to: 'checkout#cancer', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end

  resources :attendances
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
