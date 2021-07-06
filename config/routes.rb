# frozen_string_literal: true

Rails.application.routes.draw do

  resources :categories
  root to: 'events#index'

  get "events/filter/:filter", to: 'events#index', as: 'filtered_events'

  resources :events do
    resources :registrations
    resources :likes
  end

  resources :users
  get 'signup', to: 'users#new'

  resource :session, only: %i[new create destroy]
  get 'signin', to: 'sessions#new'
end
