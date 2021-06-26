Rails.application.routes.draw do
  resources :registrations
  root to: 'events#index'

  resources :events do
    resources :registrations
  end
  # get '/events', to: 'events#index'
  # get '/events/new', to: 'events#create'
  # get '/events/:id', to: 'events#show', as: 'event'
  # get '/events/:id/edit', to: 'events#edit', as: 'event_edit'
  # patch '/events/:id', to: 'events#update'
end
