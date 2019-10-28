Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    get 'users/sms' => 'users/registrations#sms'
  end
  root to: "items#index"

  resources :users, only: [:show, :new, :edit] do
    collection do
      get :smsConfirmation
      get :done
    end
    member do
      get :myitem
      get :profile
      get :logout
    end
  end

  resources :items do
    collection do
      get :search
      get :get_children, defaults: {format: 'json'}
      get :get_grandchildren, defaults: {format: 'json'}
      get :getCategory, defaults: {format: 'json'}
      get :getAllCategory, defaults: {format: 'json'}
    end
    member do
      get :pre_edit
    end
  end
  # 後日確認
  resources :categories, only: [:show, :index]
  resources :addresses, only: [:new, :create, :edit, :update]
  resources :cards
  resources :orders, except: [:new, :show] do
    collection do
      post :pay, to: 'cards#pay'
    end
  end

  scope(path_names: { new: 'buy/:item_id'}) do
    resources :orders, path: 'order'
  end
  
  post   '/favorite/:item_id' => 'favorites#like',   as: 'like'
  delete '/favorite/:item_id' => 'favorites#unlike', as: 'unlike'
end
