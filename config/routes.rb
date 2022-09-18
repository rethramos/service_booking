Rails.application.routes.draw do
  devise_for :users, path: 'admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "application#hello"
end
