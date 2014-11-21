class UserFeedsController < ApplicationController

  def destroy
    
    if params[:delete_button][:provider] == "Twitter"
      delete_user_feed("Twitter")
    elsif params[:delete_button][:provider] == "Vimeo"
      delete_user_feed("Vimeo")
    end
  end

  def delete_user_feed(provider)
    feed = Feed.find_by(provider: provider, provider_uid: params[:delete_button][:provider_uid])
    user_feed = UserFeed.find_by(user_id: session[:user_id], feed_id: feed.id)
    if user_feed.destroy
      redirect_to welcome_path
    end

  end
end
