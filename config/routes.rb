Rails.application.routes.draw do

  get  "/search",         to: "searches#index",   as: :search
  post "/search",         to: "searches#results"


  post "/auth/:developer/callback", to: "sessions#create"
  post "/sessions/create", to: "sessions#create"
  get "/sessions/welcome", to: "sessions#welcome", as: :welcome

  post "/sessions/logout", to: "sessions#logout", as: :logout

  root "home#index"

end