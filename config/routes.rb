Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root "items#index"
  resources :items do
    resources :orders, only: [:index, :create]
    resources :comments, only: :create
    collection do
      get 'search_tag'
      get 'search_item'
    end
  end
  resources :addresses, only: [:new, :create]
  resources :cards, only: [:new, :create]
  resources :users, only: [:show, :edit, :update]
end