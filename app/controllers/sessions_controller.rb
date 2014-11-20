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
      @credentials = Credential.find_by(user_id: @user.id)
    end

    def logout
      session[:user_id] = nil
      flash[:notice] = "You have logged out successfully!"
      redirect_to root_path
    end




end
