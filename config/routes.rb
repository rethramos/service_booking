Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
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
  root 'static_pages#home'

  get '*path', to: 'static_pages#home', constraints: ->(request) do
    !request.xhr? && request.format.html?
  end
end
