class FeedsController < ApplicationController

  before_action :logged_in?, only: [:create]
  rescue_from UserFeed::FeedError, with: :redirect_to_search

  def create
    if feed = Feed.find_existing_feed(params[:add_form])
      UserFeed.add_existing_feed(feed, session)
      redirect_to welcome_path, notice: "#{feed.handle} added to your feed!"
    else
      feed = UserFeed.create_new_feed(params)
      UserFeed.create_user_feed_and_posts(feed, session[:user_id])
      redirect_to welcome_path, notice: "#{feed.handle} added to your feed!"
    end
  end

  def update
    Post.refresh_posts(session[:user_id])
    redirect_to welcome_path, notice: "Feed Refreshed!"
  end

  def bulk_happy
    Feed.bulk_happy(session[:user_id])
    redirect_to welcome_path, notice: "You feed is now infused with happy!"
  end


  private

  def redirect_to_search
    redirect_to search_path, notice: "Something went wrong! :("
  end

end
