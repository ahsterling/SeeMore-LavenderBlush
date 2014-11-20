class SessionsController < ApplicationController
  before_action :logged_in?, only: [:welcome]

  def create
    # Find or create a user here
    # Sign that user in
    auth_hash = request.env['omniauth.auth']
    user = User.find_by(name: auth_hash.info.name)

    if user == nil
      user = User.new(
              name: auth_hash.info.name,
              email: auth_hash.info.email)
      if user.save
        Credential.create(
              user_id: user.id,
              provider: auth_hash.provider,
              uid: auth_hash.uid)
      else
        redirect_to root_path
      end
    end

    session[:user_id] = user.id
    redirect_to welcome_path, notice: "You have logged in sucessfully!"
  end


  def welcome
    @user = User.find_by(id: session[:user_id])
    @providers = Credential.where(user_id: @user.id).collect { |c| c.provider }

    possible_providers = ['developer', 'instagram']

    @providers.each do |p|
      possible_providers.delete(p)
    end

    @new_providers = possible_providers
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: "You have logged out successfully!"
  end
end
