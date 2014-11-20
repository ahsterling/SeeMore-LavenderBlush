class Post < ActiveRecord::Base
  belongs_to :feed
  has_many :users, through: :feeds
end
