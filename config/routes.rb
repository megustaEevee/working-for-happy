Rails.application.routes.draw do
  devise_for :users
  root to: "jikans#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :jikans, only: [:index, :show, :create] do
    resources :wages, only: [:show, :create]
    resource :comments, only: :create
  end
  resources :users, only: :show

end
