class UserFeedsController < ApplicationController

  def destroy
    provider  = params[:delete_button][:provider]
    uid       = params[:delete_button][:provider_uid]
    feed      = Feed.find_by(provider: provider, provider_uid: uid)
    user_feed = UserFeed.find_by(user_id: session[:user_id], feed_id: feed.id)

    if user_feed.destroy
      redirect_to welcome_path
    end
  end
end
