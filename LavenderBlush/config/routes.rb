Rails.application.routes.draw do

  get  "/search",         to: "searches#index",   as: :search
  post "/search",         to: "searches#results"

  post "/auth/:developer/callback", to: "session#create"

  root "home#index"

end
