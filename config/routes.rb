Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :admin do
    root 'static_pages#home'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    resources :businesses, only: %i[index show] do
      resources :services
      resources :service_categories, only: %i[new create]
    end
    resources :service_categories, only: %i[edit update destroy]
    resources :appointments, only: %i[new create edit update destroy]
  end

  # Defines the root path route ("/")
  root 'application#hello'
end
