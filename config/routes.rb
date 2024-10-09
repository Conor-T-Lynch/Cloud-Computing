Rails.application.routes.draw do
  devise_for :users  # Devise automatically creates sign in and sign out routes

  resources :articles

  # Other routes...
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest"

  # Defines the root path route ("/")
  # root "posts#index"
end
