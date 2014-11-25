require 'rails_helper'

describe FeedsController do

  let!(:test_user1) {User.create(name: "dog")}
  let!(:test_user2) {User.create(name: "pig")}
  let!(:uid) {8553052}

  describe "POST #create" do

    it 'is suceessful with a valid record' do
      post :create, {add_form: {handle: "bookis", provider: "Twitter", provider_uid: uid}}, {user_id: test_user1.id}
      expect(response).to redirect_to(welcome_path)
    end

    it 'not successful with an invalid record' do
      post :create, {add_form: {provider: "Twitter", provider_uid: 123}}, {user_id: test_user1.id}
      expect(response).to redirect_to(search_path)
    end

    context "creating and finding feeds" do

      it 'does not create duplicate feed' do
        Feed.create(handle: "bookis", provider: "Twitter", provider_uid: uid)
        feed_count = Feed.all.count
        post :create, {add_form: {handle: "bookis", provider: "Twitter", provider_uid: uid}}, {user_id: test_user1.id}
        expect(Feed.all.count).to eq feed_count
      end

      it 'creates new Feed if not existing in database' do
        feed_count = Feed.all.count
        post :create, {add_form: {handle: "bookis", provider: "Twitter", provider_uid: uid}}, {user_id: test_user1.id}
        expect(Feed.all.count).to eq feed_count + 1
      end

    end

    context "creating userfeeds" do

      it 'does not create duplicate user feed' do
        post :create, {add_form: {handle: "bookis", provider: "Twitter", provider_uid: uid}}, {user_id: test_user1.id}
        user_feed_count = UserFeed.all.count
        post :create, {add_form: {handle: "bookis", provider: "Twitter", provider_uid: uid}}, {user_id: test_user1.id}
        expect(UserFeed.all.count).to eq user_feed_count
      end

      it 'creates new UserFeed if not existing in database when only feed_id matches' do
        post :create, {add_form: {handle: "bookis", provider: "Twitter", provider_uid: uid}}, {user_id: test_user2.id}
        user_feed_count = UserFeed.all.count
        post :create, {add_form: {handle: "bookis", provider: "Twitter", provider_uid: uid}}, {user_id: test_user1.id}
        expect(UserFeed.all.count).to eq user_feed_count + 1
      end

      it 'creates new UserFeed if not existing in database when only user_id matches' do
        post :create, {add_form: {handle: "bookis", provider: "Twitter", provider_uid: uid}}, {user_id: test_user1.id}
        feed_id = Feed.last.id

        post :create, {add_form: {handle: "bookis", provider: "Vimeo", provider_uid: 123}}, {user_id: test_user1.id}
        expect(Feed.last.id).to_not eq feed_id
      end

    end
  end

  describe "POST #update" do
    context "refreshing feeds" do

      it 'refreshes successfully' do
        post :create, {add_form: {handle: "bookis", provider: "Twitter", provider_uid: uid}}, {user_id: test_user1.id}
        post :update, {user_id: test_user1.id}
        expect(response).to redirect_to welcome_path
      end

    end
  end
end
