class Feed < ActiveRecord::Base
  has_many :posts
  has_many :user_feeds
  has_many :users, through: :user_feeds


  validates :handle, :provider, presence: true
  validates :provider_uid, presence: true, numericality: true

  def self.find_existing_feed(feed_info)
    self.find_by(provider: feed_info[:provider], provider_uid: feed_info[:provider_uid])
  end

  def self.bulk_happy(user_id)
    happy_hash = { "785588682" => ["emergency_fox", "emergency_fox.jpg", "https://twitter.com/emergency_fox"],
                   "19638752"  => ["NicestHippo", "nicest_hippo.png", "https://twitter.com/nicesthippo"],
                   "568825492" => ["CuteEmergency", "cute_emergency.jpeg", "https://twitter.com/cuteemergency"],
                   "17045060"  => ["NationalZoo", "national_zoo.jpeg", "https://twitter.com/nationalzoo"],
                   "1337271"   => ["darth", "darth.jpeg", "https://twitter.com/darth"],
                   "627799297" => ["iamkidpresident", "kid_president.jpeg", "https://twitter.com/iamkidpresident"],
                   "15473958"  => ["MarsCuriosity", "mars_curiosity.jpeg", "https://twitter.com/marscuriosity"],
                   "740109097" => ["SarcasticRover", "sarcastic_rover.jpeg", "https://twitter.com/sarcasticrover"],
                   "19725644"  => ["neiltyson", "neil_tyson.jpg", "https://twitter.com/neiltyson"],
                   "549571045" => ["FacesAndThings", "faces_things.jpg", "https://twitter.com/facesandthings"] }

    happy_hash.each do |key, value|
      unless feed = self.find_existing_feed({ provider: "Twitter", provider_uid: key })
        feed = Feed.create(
          handle: value[0],
          provider: "Twitter",
          provider_uid: key,
          avatar: value[1], 
          profile_url: value[2]
        )
      end
      unless UserFeed.find_existing_user_feed(user_id, feed)
        UserFeed.create(feed_id: feed.id, user_id: user_id)
        Post.get_new_feed_posts(feed)
      end
    end
  end

end
