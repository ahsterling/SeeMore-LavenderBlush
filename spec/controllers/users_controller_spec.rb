require 'rails_helper'

describe UsersController do

  describe 'GET show' do
    it 'returns HTTP success' do
      get :show
      expect(response.status).to eq 200
    end
  end

end
