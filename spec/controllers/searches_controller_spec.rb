require 'rails_helper'

describe SearchesController do

  describe 'GET "index"' do
    it 'is successful' do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe 'POST "results"' do
    context 'Twitter search' do
      it 'displays results page with valid provider' do
        post :results, username: "Bookis", provider: "Twitter"
        expect(response.status).to eq 200
      end

      it 'does not display results page with invalid provider' do
        post :results, username: "Bookis", provider: "foobar"
        expect(response).to redirect_to(search_path)
      end

      it 'does not display results page without provider' do
        post :results, username: "Bookis"
        expect(response).to redirect_to(search_path)
      end

      it 'catches no search query' do
        post :results, username: "", provider: "Twitter"
        expect(response).to redirect_to(search_path)
      end

      it 'sets @bookis if no results found' do
        post :results, username: "aawegawg920j2vn8g2479913sj0x", provider: "Twitter"
        expect(assigns(:bookis)).to be_a Twitter::User
      end

      it 'does not set @bookis if results found' do
        post :results, username: "bookis", provider: "Twitter"
        expect(assigns(:bookis)).to eq nil
      end
    end
  end

end
