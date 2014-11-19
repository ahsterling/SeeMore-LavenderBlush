class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  use OmniAuth::Strategies::Developer

  def logged_in?
    if session[:user_id] == nil
      redirect_to root_path
    end
  end
end
