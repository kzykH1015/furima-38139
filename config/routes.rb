Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users
  root "items#index"
  resources :items do
    resources :orders, only: [:index, :create]
    collection do
      get 'search'
    end
  end
  resources :addresses, only: [:new, :create]
  resources :cards, only: [:new, :create]
end