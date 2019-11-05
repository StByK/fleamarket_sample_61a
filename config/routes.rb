Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: "users/registrations"}

  root 'items#index'


  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      get :logout
    end
  end

  resources :items do
    collection do
      get :sell
    end
  end

  resources :signup do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      get 'step4' #入力おしまい
      get 'done' # 登録完了のページ
    end
  end

end