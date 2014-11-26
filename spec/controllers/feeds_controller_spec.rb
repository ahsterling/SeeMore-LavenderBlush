require 'rails_helper'

describe FeedsController do

  let!(:test_user1) { User.create(name: "dog") }
  let!(:test_user2) { User.create(name: "pig") }
  let(:uid) { 8553052 }
  let(:form_params) { {add_form: {handle: "bookis", provider: "Twitter", provider_uid: uid}} }
  let(:session_hash) { {user_id: test_user1.id} }

  describe "POST #create" do

    it 'is suceessful with a valid record' do
      expect(Post).to receive(:get_new_feed_posts).and_return(true)

      post :create, form_params, {user_id: test_user1.id}
      expect(response).to redirect_to(welcome_path)
    end

    it 'redirects with an invalid record' do
      post :create, {add_form: {provider: "Twitter", provider_uid: 123}}, session_hash
      expect(response).to redirect_to(search_path)
    end

    context "creating and finding feeds" do

      it 'does not create duplicate feed' do
        allow(Post).to receive(:get_new_feed_posts).and_return(true)

        post :create, form_params, session_hash
        expect {
          post :create, form_params, session_hash
        }.to change(Feed, :count).by(0)
      end

      it 'creates new Feed if not existing in database' do
        allow(Post).to receive(:get_new_feed_posts).and_return(true)

        expect {
          post :create, form_params, session_hash
        }.to change(Feed, :count).by(1)
      end

    end

    context "creating userfeeds" do

      it 'does not create duplicate user feed' do
        allow(Post).to receive(:get_new_feed_posts).and_return(true)

        post :create, form_params, session_hash
        expect {
          post :create, form_params, session_hash
        }.to change(UserFeed, :count).by(0)
      end

      it 'creates new UserFeed if not existing in database when only feed_id matches' do
        allow(Post).to receive(:get_new_feed_posts).and_return(true)

        post :create, form_params, {user_id: test_user2.id}
        expect {
          post :create, form_params, session_hash
        }.to change(UserFeed, :count).by(1)
      end

      it 'creates new UserFeed if not existing in database when only user_id matches' do
        allow(Post).to receive(:get_new_feed_posts).and_return(true)

        post :create, form_params, session_hash
        expect {
          post :create, {add_form: {handle: "bookis", provider: "Vimeo", provider_uid: 123}}, session_hash
        }.to change(UserFeed, :count).by(1)
      end

    end
  end

  describe "POST #update" do
    context "refreshing feeds" do

      it 'refreshes successfully' do
        allow(Post).to receive(:get_new_feed_posts).and_return(true)

        post :create, form_params, session_hash
        post :update, {user_id: test_user1.id}
        expect(response).to redirect_to welcome_path
      end

    end
  end
end
