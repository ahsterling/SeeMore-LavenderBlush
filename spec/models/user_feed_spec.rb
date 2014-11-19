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
end
