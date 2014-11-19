class User < ActiveRecord::Base

  validates :name, presence: true

  has_many :user_feeds
  has_many :feeds, through: :user_feeds


  def has_feed?(result)
    self.feeds.collect { |f| f.provider_uid }.include?(result.id)
  end

end
