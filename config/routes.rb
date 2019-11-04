Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks', 
    registrations: "users/registrations"}


  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

  resources :users, only: :index do
    collection do
      get :logout
    end
  end

  resources :items do
    collection do
      get :sell
    end
  end

end