class FeedsController < ApplicationController

  def create
    unless feed = Feed.find_existing_feed(params[:add_form])
      feed = Feed.new(params.require(:add_form).permit(:provider, :provider_uid, :handle, :avatar, :display_name))
      if feed.save
        get_posts(feed)
      else
        redirect_to search_path, notice: "Sorry, something went wrong - feed not saved :(" and return
      end
    end

    if UserFeed.find_existing_user_feed(session, feed)
      redirect_to search_path, notice: "Sorry, something went wrong - user feed exists already" and return
    else
      user_feed = UserFeed.new(user_id: session[:user_id], feed_id: feed.id)
      if user_feed.save
        redirect_to welcome_path, notice: "#{feed.display_name} added to your feed!" and return
      else
        redirect_to search_path, notice: "Sorry, something went wrong - user_feed not saved :(" and return
      end
    end
  end




  def get_posts(feed)
    if feed.provider == "Twitter"
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
      end
      client.user_timeline(feed.provider_uid).each do |tweet|
        Post.create(date: tweet.created_at, text_content: tweet.text, feed_id: feed.id)
      end
    elsif feed.provider == "Vimeo"
      Vimeo::Simple::User.all_videos(feed.provider_uid).each do |video|
        Post.create(
          date: video["upload_date"],
          text_content: video["title"],
          media_url: video["url"],
          feed_id: feed.id)
      end
    end
  end

end
