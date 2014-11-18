Rails.application.routes.draw do
  get "/", to: "twitters#search"
end
