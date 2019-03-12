Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :spots do
    resources :advices
    resources :photos, only: [:new, :create, :destroy]
    resources :difficulty_levels, only: [:new, :create]
    resources :reviews, only: [:new, :create, :delete]
  end
end

