class SessionController < ApplicationController

    def create
      # Find or create a user here
      # Sign that user in
      auth_hash = request.env['omniauth.auth']
      user = User.new(name: auth_hash.info.name, email: auth_hash.info.email)
      if user.save
        session[:user_id] = user.id
        
        redirect_to "/sessions/welcome/"
      else
        redirect_to root_path
      end

    end


    def welcome(auth_hash)
      @name = auth_hash.info.name
      @email = auth_hash.info.email
      @provider = auth_hash.provider
      @uid = auth_hash.uid

    end



end
