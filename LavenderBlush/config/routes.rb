Rails.application.routes.draw do


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  get "/twitter-search", to: "twitters#index", as: :twitter_search
  post "/twitter-search", to: "twitters#search"


  post "/auth/:developer/callback", to: "session#create"
  get "/sessions/welcome", to: "sessions#welcome", as: :welcome

  root "home#index"

end
