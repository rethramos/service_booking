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
    resources :service_categories, only: [:new, :create]
    resources :businesses, only: [:index, :show]
  end

  # Defines the root path route ("/")
  root "application#hello"
end
