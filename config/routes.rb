Rails.application.routes.draw do
  resources :photos, only: %i[index create destroy]

  get "up" => "rails/health#show", as: :rails_health_check

  root "photos#index"
end
