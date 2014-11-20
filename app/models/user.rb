class User < ActiveRecord::Base

  validates :name, presence: true

  has_many :user_feeds
  has_many :feeds, through: :user_feeds
  has_many :posts, through: :feeds


  def has_feed?(result_id)
    self.feeds.collect { |f| f.provider_uid }.include?(result_id)
  end

end
