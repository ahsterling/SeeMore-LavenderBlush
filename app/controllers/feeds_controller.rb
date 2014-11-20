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
    ################ for test purposes ###########
    test_feed = Feed.create(handle: "perolovkindgren",
                            provider: "Vimeo",
                            provider_uid: 556981)
    UserFeed.create(feed_id: test_feed.id,
                                user_id: @user.id)
    @videos = Vimeo::Simple::User.all_videos("perolovkindgren")
    @videos.each do |video|
      Post.create(date: video["upload_date"],
                  text_content: video["title"],
                  media_url: video["url"],
                  feed_id: test_feed.id)
    end
    ################  ###########
    @posts = @user.posts
  end

  def twitter # for testing, too!
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
    end

    @tweets = client.user_timeline(8553052)
  end





end



#  @videos = Vimeo::Simple::User.all_videos("matthooks")
#  @videos = Vimeo::Simple::User.all_videos("user1557244")
#  @videos = Vimeo::Simple::User.all_videos("80781613")
#  @videos = Vimeo::Simple::User.all_videos("perolovkindgren")
