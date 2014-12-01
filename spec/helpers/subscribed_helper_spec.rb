require 'rails_helper'

describe SubscribedHelper do

  describe '#subscribed?' do
    it 'returns false when user is not subscribed to feed' do
      user = User.create()
      expect(self).to receive(:current_user).and_return(user)
      expect(subscribed?(568825492)).to eq false

    end

    it 'returns true when user is subscribed to feed' do
      user = User.create()
      feed = Feed.create(provider_uid: 568825492, handle: "cuteemergency", provider: "Twitter")
      UserFeed.create(feed_id: feed.id, user_id: user.id)
      expect(self).to receive(:current_user).and_return(user)
      expect(subscribed?(568825492)).to eq true
    end
  end

end
