Rails.application.routes.draw do

  get  "/search",         to: "searches#index",   as: :search
  post "/search",         to: "searches#results"


  post "/auth/:developer/callback", to: "sessions#create"

  # For testing:
  post "/sessions/create", to: "sessions#create"
  get "/sessions/welcome", to: "sessions#welcome", as: :welcome

  post "/sessions/logout", to: "sessions#logout", as: :logout

  get  "/feeds",           to: "feeds#index",     as: :feeds
  post "/feeds",           to: "feeds#create"

  get "/feeds/vimeo",      to: "feeds#vimeo"

  root "home#index"

end
