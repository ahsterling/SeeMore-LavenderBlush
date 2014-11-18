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
        expect(response.status).to_not eq 200
      end

      it 'does not display results page without provider' do
        post :results, username: "Bookis"
        expect(response.status).to_not eq 200
      end

      # it 'catches no search query' do
      #   post :results, username: "", provider: "Twitter"
      #   expect(response.status).to eq 200
      # end
    end
  end

end
