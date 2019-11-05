Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks', 
    registrations: "users/registrations"}

  devise_for :users, controllers: {registrations: "users/registrations"} #ユーザー新規登録画面
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new" #ユーザーログイン画面
    get "sign_out", :to => "users/sessions#destroy"
  end

  resources :users, only: :index do
    collection do
      get :logout #ログアウト確認画面
    end
  end

  resources :items do
    collection do
      get :sell
    end
  end

end