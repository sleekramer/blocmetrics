Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    match '/events', to: 'events#preflight', via: [:options]
    resources :events, only: [:create]
  end

  resources :users, only: [] do
    resources :registered_applications
  end

  authenticated :user do
    root 'registered_applications#index', as: :authenticated
  end

  devise_for :users
  root to: 'welcome#about'

end
