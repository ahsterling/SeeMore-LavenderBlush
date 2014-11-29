require 'rails_helper'

describe SearchesController do

  let!(:test_user) {User.create(name: "cat")}
  let(:bookis_params) { {username: "Bookis", provider: "Twitter"} }
  let(:session_data) { {user_id: test_user.id} }

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
        post :results, bookis_params
        expect(response).to redirect_to(root_path)
      end

      it 'does not display results page with invalid provider' do
        post :results, {username: "Bookis", provider: "foobar"}, session_data
        expect(response).to redirect_to(search_path)
      end

      it 'does not display results page without provider' do
        post :results, {username: "Bookis"}, session_data
        expect(response).to redirect_to(search_path)
      end
    end

    context 'Twitter search' do
      it 'displays results page with valid provider' do
        post :results, bookis_params, session_data
        expect(response.status).to eq 200
      end

      it 'catches no search query' do
        post :results, {username: "", provider: "Twitter"}, session_data
        expect(response).to redirect_to(search_path)
      end

      it 'sets @bookis if no results found' do
        post :results, {username: "aawegawg920j2vn8g2479913sj0x", provider: "Twitter"}, session_data
        expect(assigns(:bookis)).to be_a Twitter::User
      end

      it 'does not set @bookis if results found' do
        post :results, bookis_params, session_data
        expect(assigns(:bookis)).to eq nil
      end
    end

    context 'Vimeo search' do
      it 'displays results page with valid provider' do
        post :results, {username: "Bookis", provider: "Vimeo"}, session_data
        expect(response.status).to eq 200
      end

      it 'catches no search query' do
        post :results, {username: "", provider: "Vimeo"}, session_data
        expect(response).to be_successful # doesn't have a specific catch, but no error if thrown
      end

      it 'does not freak out when no results' do
        post :results, {username: "agj;owgijao2gin20g 0unszvnwanwban", provider: "Vimeo"}, session_data
        expect(response).to be_successful
      end
    end

  end

end
