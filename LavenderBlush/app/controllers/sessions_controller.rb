class SessionsController < ApplicationController

    def create
      # Find or create a user here
      # Sign that user in
      auth_hash = request.env['omniauth.auth']
      user = User.new(
              name: auth_hash.info.name,
              email: auth_hash.info.email)
      if user.save
        credential = Credential.create(
              user_id: user.id,
              provider: auth_hash.provider,
              uid: auth_hash.uid)
        session[:user_id] = user.id

        redirect_to welcome_path
      else
        redirect_to root_path
      end

    end


    def welcome
      @user = User.find(session[:user_id])
      @credentials = Credential.find_by(user_id: @user.id)

    end



end
