Rails.application.config.middleware.use OmniAuth::Builder do
    provider :developer unless Rails.env.production?
    provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"]
    provider :instagram, ENV['INSTAGRAM_ID'], ENV['INSTAGRAM_SECRET']
    provider :vimeo, ENV['VIMEO_KEY'], ENV['VIMEO_SECRET']
    provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']

  end
