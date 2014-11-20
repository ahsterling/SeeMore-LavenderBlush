require 'rails_helper'  # keeps the file DRY so you don't have to refer back to rails_helper.rb

# RSpec.describe Post, :type => :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end


describe User do


  describe '.validates' do
    # period indicates this is a class method while octothorp implies instance method
    # describe is only for humans 'it' is the test
    # you could use one 'it' for all four of the following tests
    # but within each 'it' we have a clean slate so there is no interaction
    # between data for different tests





  end

  describe '.has_feed?' do
    let(:user) {User.create(name: "cat")}
    let(:feed) {Feed.create(handle: "catz", provider: "Twitter", provider_uid: 123)}
    let(:user_feed) {UserFeed.create(user_id: user.id, feed_id: feed.id)}

    it 'is true if provided feed matches existing feeds' do
      user_feed
      expect(user.has_feed?(123)).to eq true
    end

    it 'is false if provided feed matches existing feeds' do
      user_feed
      expect(user.has_feed?(456)).to eq false
    end
  end

end
