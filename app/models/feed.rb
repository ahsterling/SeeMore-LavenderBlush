class Feed < ActiveRecord::Base

  has_many :user_feeds
  has_many :users, through: :user_feeds

  validates :handle, :provider, presence: true
  validates :provider_uid, presence:true, numericality: true
end
