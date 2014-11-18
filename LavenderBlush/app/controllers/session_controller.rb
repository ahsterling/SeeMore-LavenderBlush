class SessionController < ApplicationController

    def create
      # Find or create a user here
      # Sign that user in
      auth_hash = request.env['omniauth.auth']
      redirect_to root_path

    end



end
