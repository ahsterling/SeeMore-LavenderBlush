Rails.application.routes.draw do

  get  "/search",         to: "searches#index",   as: :search
  post "/search",         to: "searches#results"

  get  "/auth/:developer/callback", to: "sessions#create"
  post "/auth/:developer/callback", to: "sessions#create"

  # For testing:
  post "/sessions/create", to: "sessions#create"
  get "/sessions/welcome", to: "sessions#welcome", as: :welcome

  post "/sessions/logout", to: "sessions#logout", as: :logout

  get  "/feeds",           to: "feeds#feed",     as: :feeds
  post "/feeds",           to: "feeds#create"

  get "/feeds/vimeo",      to: "feeds#vimeo"
  get "/feeds/twitter",    to: "feeds#twitter"

  root "home#index"

end
