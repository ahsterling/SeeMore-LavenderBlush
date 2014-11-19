require 'rails_helper'

describe FeedsController do
  describe "POST #create" do
    it 'is suceessful with a valid record' do
      post :create, {add_form: {handle: "bookis", provider: "Twitter", provider_uid: 123}}, {user_id: 123}
      expect(response).to redirect_to(welcome_path)
    end

    it 'not successful with an invalid record' do
      post :create, {add_form: {provider: "Twitter", provider_uid: 123}}, {user_id: 123}
      expect(response).to redirect_to(search_path)
    end

    it 'does not create duplicate feed' do
      Feed.create(handle: "bookis", provider: "Twitter", provider_uid: 123)
      feed_count = Feed.all.count
      post :create, {add_form: {handle: "bookis", provider: "Twitter", provider_uid: 123}}, {user_id: 123}
      expect(Feed.all.count).to eq feed_count
    end

    it 'creates new Feed if not existing in database' do
      feed_count = Feed.all.count
      post :create, {add_form: {handle: "bookis", provider: "Twitter", provider_uid: 123}}, {user_id: 123}
      expect(Feed.all.count).to eq feed_count + 1
    end
  end
  # creates new Feed when it doesn't already exist
  # creates new UserFeed when new Feed

  # doesn't create new Feed when Feed already exists
  # creates new UserFeed when there's an existing Feed

  # doesn't create new UserFeed when UserFeed already exists

end
