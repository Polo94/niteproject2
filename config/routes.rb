require 'sidekiq/web'

Rails.application.routes.draw do
  resources :goods do
    member do
      put "add", to: "goods#opinion"
      put "remove", to: "goods#opinion"
      get "details", to: 'goods#details'
   end
  end
  resources :opinion, only: [:index]
  resources :pricing, only: [:index]
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users
  root to: 'goods#home'
  resources :subscriptions
  resources :goods, only: [] do
    resources :reviews, only: [:index, :update, :show]
  resources :goods
  resources :user
  end
  match '/agency/:agency_id/goods', :to => "goods#agency_index", via: [:get]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
