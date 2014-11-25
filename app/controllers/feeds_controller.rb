class FeedsController < ApplicationController

  class FeedError < RuntimeError; end

  before_action :logged_in?, only: [:create]
  rescue_from FeedsController::FeedError, with: :redirect_to_search

  def create
    if feed = Feed.find_existing_feed(params[:add_form])
      add_existing_feed(feed)
    else
      feed = create_new_feed(params)
      create_user_feed_and_posts(feed)
    end
  end

  def update
    Post.refresh_posts(session[:user_id])
    redirect_to welcome_path, notice: "Feed Refreshed!"
  end


  private

  def add_existing_feed(feed)
    if UserFeed.find_existing_user_feed(session, feed)
      raise FeedError.new
    else
      create_user_feed_and_posts(feed)
    end
  end

  def create_new_feed(params)
    feed = Feed.new(params.require(:add_form).permit(:provider, :provider_uid, :handle, :avatar, :profile_url))
    if feed.save
      feed
    else
      raise FeedError.new
    end
  end


  def create_user_feed_and_posts(feed)
    user_feed = UserFeed.new(user_id: session[:user_id], feed_id: feed.id)
    if user_feed.save
      Post.get_new_feed_posts(feed)
      redirect_to welcome_path, notice: "#{feed.handle} added to your feed!"
    else
      raise FeedError.new
    end
  end

  def redirect_to_search
    redirect_to search_path, notice: "Something went wrong! :("
  end

end
