class SessionsController < ApplicationController
  before_action :logged_in?, only: [:welcome]

  def create

    auth_hash = request.env['omniauth.auth']

    if session[:user_id] == nil
      user = User.includes(:credentials).references(:credentials).where("credentials.provider = '#{auth_hash.provider}' AND credentials.uid = '#{auth_hash.uid}'").first
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

    else
      Credential.create(user_id: current_user.id, provider: auth_hash.provider, uid: auth_hash.uid)
    end

    redirect_to welcome_path, notice: "You have been successfully signed in."
  end


  def welcome
    @user = User.find_by(id: session[:user_id])
    # @posts = @user.posts.order(date: :desc).paginate(page: params[:page]).per_page(5)
    @posts = @user.posts.order(date: :desc).page(params[:page]).per_page(5)
    
    # all_posts = SessionsHelper::FeedPage.new(@user, start)
    # @this_page = all_posts.this_page #based on start value this page will contain post at start index
    # @next_page = all_posts.next_page

  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: "You have been successfully signed out."
  end
end
