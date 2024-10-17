Rails.application.routes.draw do
  devise_for :users  # Devise automatically creates sign in and sign out routes

  resources :articles do
    collection do
      get 'search'  # Route for the search action
      get 'search_results'  # Route for the search results action
    end
  end

  # Other routes...
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest"

  # Defines the root path route ("/")
  # Uncomment and set the desired root path if needed
  # root "articles#index"
end
