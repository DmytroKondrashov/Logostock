Rails.application.routes.draw do
  namespace :admin do
    root to: "companies#index"
    
    resources :companies
    resources :practices
    resources :asset_classes
    resources :job_functions
    resources :locations
    resources :users
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
