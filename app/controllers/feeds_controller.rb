class FeedsController < ApplicationController

  class FeedError < RuntimeError; end

  rescue_from FeedsController::FeedError, with: :redirect_to_search

  def create
    if feed = Feed.find_existing_feed(params[:add_form])
      add_existing_feed(feed)
    else
      feed = create_feed(params)
      create_user_feed_and_posts(feed)
    end
  end


  private

  def add_existing_feed(feed)
    if UserFeed.find_existing_user_feed(session, feed)
      raise FeedError.new
    else
      create_user_feed_and_posts(feed)
    end
  end

  def create_feed(params)
    feed = Feed.new(params.require(:add_form).permit(:provider, :provider_uid, :handle, :avatar))
    if feed.save
      feed
    else
      raise FeedError.new
    end
  end

  def create_user_feed_and_posts(feed)
    user_feed = UserFeed.new(user_id: session[:user_id], feed_id: feed.id)
    if user_feed.save
      get_new_feed_posts(feed)
      redirect_to welcome_path, notice: "#{feed.handle} added to your feed!"
    else
      raise FeedError.new
    end
  end

  def get_new_feed_posts(feed)
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

  def redirect_to_search
    redirect_to search_path, notice: "Something went wrong! :("
  end

end
