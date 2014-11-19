require 'rails_helper'

describe Feed do

  describe ".validates" do
    it 'saves a correct Feed' do
      expect(Feed.new(provider: "Twitter", provider_uid: 123, handle: "bookis").valid?).to eq true
    end

    it "doesn't save a Feed with missing handle" do
      expect(Feed.new(provider: "Twitter", provider_uid: 123).valid?).to eq false
    end

    it "doesn't save a Feed with a missing provider" do
      expect(Feed.new(provider_uid: 123, handle: "bookis").valid?).to eq false
    end

    it "doesn't save a Feed with a missing provider_uid" do
      expect(Feed.new(provider: "Twitter", handle: "bookis").valid?).to eq false
    end

    it "doesn't save a Feed with provider_uid that is not an integer" do
      expect(Feed.new(provider: "Twitter", provider_uid: "blah", handle: "bookis").valid?).to eq false
    end
  end

end
