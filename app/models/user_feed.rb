class UserFeed < ActiveRecord::Base
  validates :user_id, :feed_id, presence: true, numericality: true
  belongs_to :user
  belongs_to :feed

  def self.find_existing_user_feed(session, feed)
    UserFeed.find_by(user_id: session[:user_id], feed_id: feed.id)
  end

end
