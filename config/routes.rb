# frozen_string_literal: true

Rails.application.routes.draw do

  root to: 'events#index'

  resources :events do
    resources :registrations
    resources :likes
  end

  resources :users
  get 'signup', to: 'users#new'

  resource :session, only: %i[new create destroy]
  get 'signin', to: 'sessions#new'
end
