Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  # to redirect user to the profile page after editing the profile:
  as :user do
    get 'users', :to => 'profiles#show', :as => :user_root # Rails 3
  end
  resource :map, only: :show
  root to: 'map#show'

  resources :spots do
    resources :advices
    resources :photos, only: [:new, :create, :destroy]
    resources :difficulty_levels, only: [:new, :create]
    resources :reviews, only: [:new, :create, :destroy]
  end

  get 'onboarding', to: "onboarding#home"
  get 'level', to: "quizz#quizz"
  get 'profile', to: "profiles#show"

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
