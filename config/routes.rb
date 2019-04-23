Rails.application.routes.draw do
  root 'home#index_one'
  get 'home/index_one'
  get 'home/index_two' 
  # devise_for :users

  get 'reset_all',  to: 'home#reset_all'
  resources :conversations, only: [:create] do
    member do
      post :close
    end

    resources :messages, only: [:create]
  end
end
