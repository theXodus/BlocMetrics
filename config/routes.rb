Rails.application.routes.draw do

  resources :registered_applications

  namespace :api, defaults: { format: :json } do
    match '/events', to: 'events#preflight', via: [:options]
    resources :events, only: [:create]
  end

  devise_for :users
  root to: "welcome#index"

end
