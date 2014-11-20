class FeedsController < ApplicationController

  def create
    feed_info = params[:add_form]

    unless feed = Feed.find_existing_feed(feed_info)
      feed = Feed.new(params.require(:add_form).permit(:provider, :provider_uid, :handle, :avatar))
      unless feed.save
        redirect_to search_path, notice: "Sorry, something went wrong - feed not saved :(" and return
      end
    end

    if UserFeed.find_existing_user_feed(session, feed)
      redirect_to search_path, notice: "Sorry, something went wrong - user feed exists already" and return
    else
      user_feed = UserFeed.new(user_id: session[:user_id], feed_id: feed.id)
      if user_feed.save
        redirect_to welcome_path, notice: "#{feed.handle} added to your feed!" and return
      else
        redirect_to search_path, notice: "Sorry, something went wrong - user_feed not saved :(" and return
      end
    end
  end


end
