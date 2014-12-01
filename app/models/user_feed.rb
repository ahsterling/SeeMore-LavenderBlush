class UserFeed < ActiveRecord::Base
  validates :user_id, :feed_id, presence: true, numericality: true
  belongs_to :user
  belongs_to :feed

  class FeedError < RuntimeError; end

  def self.find_existing_user_feed(user_id, feed)
    self.find_by(user_id: user_id, feed_id: feed.id)
  end

  def self.add_existing_feed(feed, session)
    if self.find_existing_user_feed(session[:user_id], feed)
      raise FeedError.new
    else
      self.create_user_feed_and_posts(feed, session[:user_id])
    end
  end

  def self.create_new_feed(params)
    feed = Feed.new(params.require(:add_form).permit(:provider, :provider_uid, :handle, :avatar, :profile_url))
    if feed.save
      feed
    else
      raise FeedError.new
    end
  end

  def self.create_user_feed_and_posts(feed, user_id)
    user_feed = UserFeed.new(user_id: user_id, feed_id: feed.id)
    if user_feed.save
      Post.get_new_feed_posts(feed)
    else
      raise FeedError.new
    end
  end

end
