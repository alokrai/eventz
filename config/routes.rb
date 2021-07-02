# frozen_string_literal: true

Rails.application.routes.draw do
  resources :likes
  root to: 'events#index'

  resources :events do
    resources :registrations
  end

  resources :users
  get 'signup', to: 'users#new'

  resource :session, only: %i[new create destroy]
  get 'signin', to: 'sessions#new'
end
