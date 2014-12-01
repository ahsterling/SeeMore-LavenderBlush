require 'rails_helper'

describe Feed do

  describe '.validates' do
    it 'saves a correct Feed' do
      expect(Feed.new(provider: 'Twitter', provider_uid: '123', handle: 'bookis').valid?).to eq true
    end

    it "doesn't save a Feed with missing handle" do
      expect(Feed.new(provider: 'Twitter', provider_uid: '123').valid?).to eq false
    end

    it "doesn't save a Feed with a missing provider" do
      expect(Feed.new(provider_uid: '123', handle: 'bookis').valid?).to eq false
    end

    it "doesn't save a Feed with a missing provider_uid" do
      expect(Feed.new(provider: 'Twitter', handle: 'bookis').valid?).to eq false
    end

    it "doesn't save a Feed with provider_uid that is not an integer" do
      expect(Feed.new(provider: 'Twitter', provider_uid: 'blah', handle: 'bookis').valid?).to eq false
    end
  end

  describe '#find_existing_feed' do

    let(:feed_info) { { provider: 'Twitter', provider_uid: '123' } }
    let(:feed) { Feed.create(handle: 'bookis', provider: 'Twitter', provider_uid: '123') }

    it 'returns the feed object' do
      feed
      expect(Feed.find_existing_feed(feed_info)).to be_a Feed
    end

    it 'finds the matching feed' do
      feed
      expect(Feed.find_existing_feed(feed_info).id).to eq feed.id
    end

  end

  describe '#bulk_happy' do

    let(:user) { User.create(name: 'cat') }

    it 'adds all new user_feeds if none already added' do
      expect {
        Feed.bulk_happy(user.id)
      }.to change{ user.feeds.count }.by(10)
    end

    it 'does not add duplicate user_feeds' do
      Feed.bulk_happy(user.id)
      expect {
        Feed.bulk_happy(user.id)
      }.to change{ user.feeds.count }.by(0)
    end

  end

end
