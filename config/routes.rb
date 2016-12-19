Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :links, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:create]
    end
  end
end
