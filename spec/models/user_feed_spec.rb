require 'rails_helper'

describe UserFeed do
  describe ".validates" do
    it 'saves a valid record' do
      expect(UserFeed.new(user_id: 123, feed_id: 123).valid?).to eq true
    end

    it 'does not save when user_id is missing' do
      expect(UserFeed.new(feed_id: 123).valid?).to eq false
    end

    it 'does not save when feed_id is missing' do
      expect(UserFeed.new(user_id: 123).valid?).to eq false
    end

    it 'does not save when user_id is not an integer' do
      expect(UserFeed.new(user_id: "blah", feed_id: 123).valid?).to eq false
    end

    it 'does not save when feed_id is not an integer' do
      expect(UserFeed.new(user_id: 123, feed_id: "blah").valid?).to eq false
    end
  end

  describe "#find_existing_user_feeds" do

    def self.find_existing_user_feed(session, feed)
      UserFeed.find_by(user_id: session[:user_id], feed_id: feed.id)
    end

    let(:user) {User.create(name: "cat")}
    let(:feed) {Feed.create(handle: "catz", provider: "Twitter", provider_uid: 123)}
    let(:user_feed) {UserFeed.create(user_id: user.id, feed_id: feed.id)}
    let(:session) {{user_id: user.id}}

    it 'finds UserFeed object' do
      user
      feed
      user_feed
      expect(UserFeed.find_existing_user_feed(session, feed)).to be_a UserFeed
    end

    it 'finds matching user_feed in db' do
      user
      feed
      user_feed
      expect(UserFeed.find_existing_user_feed(session, feed).id).to eq user_feed.id
    end



  end
end
