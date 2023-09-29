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

  devise_for :users, controllers: { passwords: "passwords" }
  devise_scope :user do
    # :user namespace in the controllers and views, "admin" path in the URL path ("/admin")
    # Default path for users is "/user". When we rename users to admins, we may drop `, path: "admin"`
    namespace :user, path: "admin" do
      # This is where the user gets redirected when visits /users/sign_in while being logged in (default is "/")
      root to: "/admin/companies#index"
    end
  end
end
