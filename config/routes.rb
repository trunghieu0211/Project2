Rails.application.routes.draw do
  root "posts#index"
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
    controllers: {
      omniauth_callbacks: "users/omniauth_callbacks"
    }
  resources :users, only: [:show, :index] do
    resources :posts, only: :index
  end
  resources :posts do
    resources :comments
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end
