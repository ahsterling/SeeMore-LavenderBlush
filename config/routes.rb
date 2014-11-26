Rails.application.routes.draw do

  get 'user_feeds/destroy'

  get  "/search",         to: "searches#index",   as: :search
  post "/search",         to: "searches#results"

  get  "/auth/:developer/callback", to: "sessions#create"
  post "/auth/:developer/callback", to: "sessions#create"


  # For testing:
  post "/sessions/create", to: "sessions#create"
  get "/sessions/welcome", to: "sessions#welcome", as: :welcome

  post "/users",            to: "users#update"
  get "/users/:id",        to: "users#show", as: :user


  post "/sessions/logout", to: "sessions#logout", as: :logout

  get  "/feeds",           to: "feeds#feed",     as: :feeds
  post "/feeds",           to: "feeds#create"
  patch "/feeds",          to: "feeds#update"

  get "/feeds/vimeo",      to: "feeds#vimeo"
  get "/feeds/twitter",    to: "feeds#twitter"

  #delete "/user_feeds", to: "user_feeds#destroy", as: user_feeds
  post "/user_feeds",    to: "user_feeds#destroy", as: :user_feeds
  #post "/delete_user_feeds",      to: "user_feeds#destroy"

  root "home#index"

  get "home/test", to: "home#test"

end
