Rails.application.routes.draw do
  root "posts#index"
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  resources :users, only: [:show, :index] do
    resources :posts, only: :index
  end
  resources :posts
end
