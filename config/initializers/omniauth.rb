Rails.application.config.middleware.use OmniAuth::Builder do
    provider :developer unless Rails.env.production?
    provider :github, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_SECRET"], scope: "user,repo,gist"  #username and password
    provider :instagram, ENV['INSTAGRAM_ID'], ENV['INSTAGRAM_SECRET']
    provider :vimeo, ENV['VIMEO_KEY'], ENV['VIMEO_SECRET']

  end
