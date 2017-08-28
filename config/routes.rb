Rails.application.routes.draw do
  resources :products, path: '/stores/:store_slug/products', only: :index
  resources :products, only: :index

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'home/index'

  devise_for :users
  root to: "home#index"
end
