class HomeController < ApplicationController

  def index
    if session[:user_id] != nil
      redirect_to welcome_path
    end

  end
end
