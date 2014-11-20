class FeedsController < ApplicationController

  def create
    feed_info = params[:add_form]

    unless feed = Feed.find_existing_feed(feed_info)
      feed = Feed.new(params.require(:add_form).permit(:provider, :provider_uid, :handle, :avatar))
      if feed.save
        Post.new()
      else
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

  def vimeo # for testing display
    @videos = Vimeo::Simple::User.all_videos("perolovkindgren")
  end

  def feed
    @user = User.find(session[:user_id])
    test_feed = Feed.create(handle: "perolovkindgren",
                            provider: "Vimeo",
                            provider_uid: 556981)
    @videos = Vimeo::Simple::User.all_videos("perolovkindgren")
    @videos.each do |video|
      Post.create(:)

    end
    @posts = @user.


  end
end



#  @videos = Vimeo::Simple::User.all_videos("matthooks")
#  @videos = Vimeo::Simple::User.all_videos("user1557244")
#  @videos = Vimeo::Simple::User.all_videos("80781613")
#  @videos = Vimeo::Simple::User.all_videos("perolovkindgren")
