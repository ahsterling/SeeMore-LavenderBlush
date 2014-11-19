require 'rails_helper'

describe FeedsController do
  describe "POST #create" do
    it 'is suceessful with a valid record' do
      post :create, {add_form: {handle: "bookis", provider: "Twitter", provider_uid: 123}}, {user_id: 123}
      expect(response).to redirect_to(welcome_path) 
    end
  end
  # creates new Feed when it doesn't already exist
  # creates new UserFeed when new Feed

  # doesn't create new Feed when Feed already exists
  # creates new UserFeed when there's an existing Feed

  # doesn't create new UserFeed when UserFeed already exists

end
