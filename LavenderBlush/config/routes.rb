Rails.application.routes.draw do

  get  "/search",         to: "searches#index",   as: :search
  post "/search",         to: "searches#results"


  post "/auth/:developer/callback", to: "session#create"
  get "/sessions/welcome", to: "sessions#welcome", as: :welcome

  root "home#index"

end
