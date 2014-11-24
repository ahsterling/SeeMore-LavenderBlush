class Post < ActiveRecord::Base
  belongs_to :feed
  has_many :users, through: :feeds

  def self.get_new_feed_posts(feed)
    if feed.provider == "Twitter"
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
      end
      client.user_timeline(feed.provider_uid.to_i).each do |tweet|
        Post.create(date: tweet.created_at, text_content: tweet.text, feed_id: feed.id)
      end
    elsif feed.provider == "Vimeo"
      Vimeo::Simple::User.all_videos(feed.provider_uid.to_i).each do |video|
        Post.create(date: video["upload_date"], text_content: video["title"], media_url: video["url"], feed_id: feed.id)
      end
    end
  end

end
