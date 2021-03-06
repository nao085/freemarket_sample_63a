Rails.application.routes.draw do
  devise_for :users
  root to: 'toppage#index'
  get 'messages/index'
  get 'messages/upp'

  resources :products, except: :index do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    member do
      get 'get_category_children', defaults: {format: 'json'}
      get 'get_category_grandchildren', defaults: {format: 'json'}
    end
    collection do
      get 'get_category_children', defaults: {format: 'json'}
      get 'get_category_grandchildren', defaults: {format: 'json'}
    end
  end

  resource :cards, only: [:new, :create,:destroy, :show]

  resources :order, only: %i[index] do
    member do
      get '/buy', to: 'orders#new'
      post '/pay', to: 'orders#pay'
      get '/done', to: 'orders#done'
    end
  end


  resources :mypages, only: [:show] do
    member do
      get 'logout', to: 'mypages#logout'
      get 'like', to: 'mypages#likes'
      get 'exhibiting', to: 'mypages#exhibiting'
      get 'in_progress', to: 'mypages#in_progress'
      get 'completed', to: 'mypages#completed'
      get 'purchase', to: 'mypages#purchase'
      get 'purchased', to: 'mypages#purchased'
    end
  end
end
