class UserFeed < ActiveRecord::Base
  validates :user_id, :feed_id, presence: true, numericality: true
  belongs_to :user
  belongs_to :feed

end
