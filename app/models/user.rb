class User < ActiveRecord::Base

  validates :name, presence: true

  has_many :user_feeds
  has_many :feeds, through: :user_feeds


end
