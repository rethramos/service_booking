Rails.application.routes.draw do
  namespace :admin do
    root 'static_pages#home'
  end

  devise_for :users, path: 'admin', controllers: {
    sessions: 'admin/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "application#hello"
end
