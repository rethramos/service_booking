Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :admin do
    get 'service_categories/index'
    get 'service_categories/show'
    get 'service_categories/edit'
    get 'service_categories/update'
    root 'static_pages#home'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    resources :businesses, only: %i[index show] do
      member do
        resources :service_categories, only: %i[new create]
        resources :services
      end
    end
  end

  # Defines the root path route ("/")
  root 'application#hello'
end
