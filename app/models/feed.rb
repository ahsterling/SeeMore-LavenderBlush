class Feed < ActiveRecord::Base
  has_many :posts
  has_many :user_feeds
  has_many :users, through: :user_feeds


  validates :handle, :provider, presence: true
  validates :provider_uid, presence:true, numericality: true

  def self.find_existing_feed(feed_info)
    self.find_by(provider: feed_info[:provider], provider_uid: feed_info[:provider_uid])
  end

  def self.bulk_happy(user_id)
    happy_hash = {"785588682" => "emergency_fox",
                  "19638752" => "NicestHippo",
                  "568825492" => "CuteEmergency",
                  "17045060" => "NationalZoo",
                  "1337271" => "darth",
                  "627799297" => "iamkidpresident",
                  "15473958" => "MarsCuriosity",
                  "740109097" => "SarcasticRover",
                  "19725644" => "neiltyson",
                  "549571045" => "FacesAndThings"
    }

    happy_hash.each do |key, value|
      unless feed = self.find_existing_feed({ provider: "Twitter", provider_uid: key })
        feed = Feed.create(handle: value, provider: "Twitter", provider_uid: key)
      end
      unless UserFeed.find_existing_user_feed({session: user_id}, feed)
        UserFeed.create(feed_id: feed.id, user_id: user_id)
      end
      Post.get_new_feed_posts(feed)
    end
  end

end
