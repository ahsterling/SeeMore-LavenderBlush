class User < ActiveRecord::Base


  #validates :name, presence: true


  has_many :user_feeds
  has_many :feeds, through: :user_feeds
  has_many :posts, through: :feeds
  has_many :credentials


  def has_feed?(result_id)
    self.feeds.collect { |f| f.provider_uid }.include?(result_id)
  end

  def other_providers
    all_providers = ["twitter", "instagram", "vimeo", "github"]
    existing_credentials = self.credentials.collect { |c| c.provider }
    non_existing_credentials = []

    all_providers.each do |p, index|
      unless existing_credentials.include?(p)
        non_existing_credentials << p
      end
    end

    return non_existing_credentials
  end

end
