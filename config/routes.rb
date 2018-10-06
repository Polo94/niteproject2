require 'sidekiq/web'

Rails.application.routes.draw do
  resources :goods do
    member do
      put "add", to: "goods#opinion"
      put "remove", to: "goods#opinion"
   end
  end
  resources :opinion, only: [:index]
  resources :pricing, only: [:index]
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'goods#index'
  resources :subscriptions
  resources :goods, only: [] do
    resources :reviews, only: [:index, :update, :show]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
