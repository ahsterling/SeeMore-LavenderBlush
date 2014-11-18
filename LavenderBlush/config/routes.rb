Rails.application.routes.draw do

  get "/twitter-search", to: "twitters#index", as: :twitter_search
  post "/twitter-search", to: "twitters#search"

  post "/auth/:developer/callback", to: "session#create"

  root "home#index"

end
