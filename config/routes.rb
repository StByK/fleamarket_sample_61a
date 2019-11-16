Rails.application.routes.draw do
  get 'purchase/index'
  get 'purchase/done'
  get 'brands/index'
  get 'categories/index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: "users/registrations"}

  root 'items#index'

  # devise_scope :user do
  #   get "sign_in", :to => "users/sessions#new"
  #   get "sign_out", :to => "users/sessions#destroy"
  # end

  resources :users, only: [:show, :edit, :update] do
    member do
      get :logout
      get :identification
    end
    member do
      get "user_item_show"
    end
  end

  resources :items do
    resources :images
    resources :purchase, only: [:index] do
      collection do
        get 'index', to: 'purchase#index'
        post 'pay', to: 'purchase#pay'
        get 'done', to: 'purchase#done'
      end
    end
  end


  resources :categories, only: :show do
  end

  resources :brands, only: :show do
  end

  resources :sessions, only: :new do
  end


  resources :signup ,only: [:new] do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      get 'step4' #入力おしまい
      get 'done' # 登録完了のページ
    end

    collection do
      post :create
    end
  end

  resources :card, only: [:new,:show] do
    collection do
      post 'delete', to: 'card#delete'
      post 'create', to: 'card#create'
      post 'show', to:'card#show'
    end
    member do
      get 'confirmation'
      get 'new', to: 'card#new'
    end
  end 
end