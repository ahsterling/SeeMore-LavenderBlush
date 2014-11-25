require 'rails_helper'

describe SearchesController do

  let!(:test_user) {User.create(name: "cat")}

  describe 'GET "index"' do

    it 'is successful' do
      get :index, nil, {user_id: test_user.id}
      expect(response.status).to eq 200
    end

    it 'redirects when not logged in' do
      get :index
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST "results"' do

    context 'General search' do
      it 'redirects when not logged in' do
        post :results, {username: "Bookis", provider: "Twitter"}
        expect(response).to redirect_to(root_path)
      end

      it 'does not display results page with invalid provider' do
        post :results, {username: "Bookis", provider: "foobar"}, {user_id: test_user.id}
        expect(response).to redirect_to(search_path)
      end

      it 'does not display results page without provider' do
        post :results, {username: "Bookis"}, {user_id: test_user.id}
        expect(response).to redirect_to(search_path)
      end
    end

    context 'Twitter search' do
      it 'displays results page with valid provider' do
        post :results, {username: "Bookis", provider: "Twitter"}, {user_id: test_user.id}
        expect(response.status).to eq 200
      end

      it 'catches no search query' do
        post :results, {username: "", provider: "Twitter"}, {user_id: test_user.id}
        expect(response).to redirect_to(search_path)
      end

      it 'sets @bookis if no results found' do
        post :results, {username: "aawegawg920j2vn8g2479913sj0x", provider: "Twitter"}, {user_id: test_user.id}
        expect(assigns(:bookis)).to be_a Twitter::User
      end

      it 'does not set @bookis if results found' do
        post :results, {username: "bookis", provider: "Twitter"}, {user_id: test_user.id}
        expect(assigns(:bookis)).to eq nil
      end
    end

    context 'Vimeo search' do
      it 'displays results page with valid provider' do
        post :results, {username: "Bookis", provider: "Vimeo"}, {user_id: test_user.id}
        expect(response.status).to eq 200
      end

      it 'catches no search query' do
        post :results, {username: "", provider: "Vimeo"}, {user_id: test_user.id}
        expect(response).to be_successful # doesn't have a specific catch, but no error if thrown
      end
    end

  end

end
