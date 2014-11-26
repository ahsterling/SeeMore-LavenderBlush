require 'rails_helper'

describe UserFeedsController do

  describe "POST destroy" do
    let!(:test_user) {User.create(name: "dog")}
    let!(:feed) {Feed.create(handle: "bookis", provider: "Twitter", provider_uid: 8553052)}
    let!(:user_feed) {UserFeed.create(user_id: test_user.id, feed_id: feed.id)}

    it "returns http success" do
      post :destroy, { delete_button: {provider: feed.provider, provider_uid: feed.provider_uid } }, { user_id: test_user.id }
      expect(response).to redirect_to welcome_path
    end
  end

end
