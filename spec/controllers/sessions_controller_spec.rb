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
      session[:user_id].should be_nil
      post :create
      session[:user_id].should_not be_nil
    end

    it "should redirect the user to welcome page" do
      post :create
      response.should redirect_to welcome_path
    end

  end

  describe "#logout" do
    before do
      post :create
    end

    it "should clear the session" do
      session[:user_id].should_not be_nil
      post :logout
      session[:user_id].should be_nil
    end

    it "should redirect to the home page" do
      post :logout
      response.should redirect_to root_path
    end
   end

end
