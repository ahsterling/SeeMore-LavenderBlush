class FeedsController < ApplicationController

  def create
    feed_info = params[:add_form]

    unless feed = Feed.find_by(provider: feed_info[:provider], provider_uid: feed_info[:provider_uid])
      feed = Feed.create(params.require(:add_form).permit(:provider, :provider_uid, :handle, :avatar))
    end

    UserFeed.create(user_id: session[:user_id], feed_id: feed.id)

    redirect_to welcome_path, notice: "#{feed.handle} added to your feed!"
  end

end
