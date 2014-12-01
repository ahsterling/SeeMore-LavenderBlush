require 'rails_helper'

describe Post do

  describe '#get_new_feed_posts' do

    let(:twitter_feed) { Feed.create(handle: 'bookis', provider: 'Twitter', provider_uid: '123') }
    let(:vimeo_feed) { Feed.create(handle: 'bookis', provider: 'Vimeo', provider_uid: '123') }

    it 'routes Twitter' do
      expect(Post).to receive(:get_tweets).and_return(true)
      expect(Post.get_new_feed_posts(twitter_feed)).to eq true
    end

    it 'routes Vimeo' do
      expect(Post).to receive(:get_videos).and_return(true)
      expect(Post.get_new_feed_posts(vimeo_feed)).to eq true
    end

  end

  describe '#get_tweets' do

    let!(:feed) {Feed.create(handle: "bookis", provider: "Twitter", provider_uid: 8553052)}

    it 'gets new posts' do
      expect {
        Post.get_tweets(feed)
      }.to change{ feed.posts.count }.by_at_least(1)
    end

  end

  describe '#get_videos' do

    let!(:feed) {Feed.create(handle: "DINOSAUR", provider: "Vimeo", provider_uid: 462248)}

    it 'gets new posts' do
      expect {
        Post.get_videos(feed)
      }.to change{ feed.posts.count }.by_at_least(1)
    end

  end

end
