Rails.application.routes.draw do

  resources :users, only: [] do
    resources :registered_applications
  end

  authenticated :user do
    root 'registered_applications#index', as: :authenticated
  end

  devise_for :users
  root to: 'welcome#about'

end
