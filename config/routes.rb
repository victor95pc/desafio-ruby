require 'sidekiq/web'
Rails.application.routes.draw do
  resources :products, path: '/store/:store_slug/products', only: :index
  resources :products, only: :index

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Sidekiq::Web => '/sidekiq'

  get 'home/index'

  devise_for :users
  root to: "home#index"
end
