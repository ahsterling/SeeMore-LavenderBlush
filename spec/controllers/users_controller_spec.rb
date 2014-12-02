require 'rails_helper'

describe UsersController do

  let(:test_user1) { User.create(name: "dog") }
  let(:test_user2) { User.create(name: "pig") }

  describe 'GET show' do

    it 'returns HTTP success' do
      get :show, {id: test_user1.id}, {user_id: test_user1.id}
      expect(response.status).to eq 200
    end

    it 'redirects if accessing someone else\'s account' do
      get :show, {id: test_user1.id}, {user_id: test_user2.id}
      expect(response.status).to eq 302
    end

  end

  describe 'POST update' do

    it 'redirects to user_path' do
      post :update, {id: test_user1.id, user: {name: "tangerine", email: "or@nge.com"}}, {user_id: test_user1.id}
      expect(test_user1).to redirect_to(user_path)
    end

    it 'updates user name' do
      post :update, {id: test_user1.id, user: {name: "tangerine", email: "or@nge.com"}}, {user_id: test_user1.id}
      expect(User.last.name).to eq "tangerine"
    end

    it 'updates user email' do
      post :update, {id: test_user1.id, user: {name: "tangerine", email: "or@nge.com"}}, {user_id: test_user1.id}
      expect(User.last.email).to eq "or@nge.com"
    end

    it 'does not update someone else\'s name' do
      post :update, {id: test_user1.id, user: {name: "tangerine", email: "or@nge.com"}}, {user_id: test_user2.id}
      expect(response).to redirect_to root_path
      expect(User.all[-2].name).to eq "dog"
    end

    it 'does not update someone else\'s email' do
      post :update, {id: test_user1.id, user: {name: "tangerine", email: "or@nge.com"}}, {user_id: test_user2.id}
      expect(response).to redirect_to root_path
      expect(User.all[-2].email).to eq nil
    end

  end

end
