Rails.application.config.middleware.use OmniAuth::Builder do
    provider :developer unless Rails.env.production?
    # provider :github, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_SECRET"]  #username and password
  end