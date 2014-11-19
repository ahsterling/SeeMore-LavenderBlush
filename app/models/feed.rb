class Feed < ActiveRecord::Base

  has_many :user_feeds
  has_many :users, through: :user_feeds

  validates :handle, :provider, presence: true
  validates :provider_uid, presence:true, numericality: true

  def self.find_existing_feed(feed_info)
    self.find_by(provider: feed_info[:provider], provider_uid: feed_info[:provider_uid])
  end
end
