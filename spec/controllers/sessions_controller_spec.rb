require 'rails_helper'

# sessions_controller_spec.rb
require 'spec_helper'

describe SessionsController do

  before do  #from https://github.com/intridea/omniauth/wiki/Integration-Testing
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:developer]
  end

  describe "#create" do

    it "should successfully create a user" do
      expect {
        post :create
      }.to change{ User.count }.by(1)
    end

    it "should successfully create a session" do
      expect(session[:user_id]).to eq nil
      post :create
      expect(session[:user_id]).not_to eq nil
    end

    it "should redirect the user to welcome page" do
      post :create
      expect(response).to redirect_to(welcome_path)
    end

  end

  describe "#logout" do
    before do
      post :create
    end

    it "should clear the session" do
      expect(session[:user_id]).not_to eq nil
      post :logout
      expect(session[:user_id]).to eq nil
    end

    it "should redirect to the home page" do
      post :logout
      expect(response).to redirect_to(root_path)
    end
   end

end
