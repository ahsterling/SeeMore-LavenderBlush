class UsersController < ApplicationController
  before_filter :user_is_current_user

  def show
    @user = current_user
    @twitter_feeds = @user.feeds.where(provider: "Twitter")
    @vimeo_feeds = @user.feeds.where(provider: "Vimeo")
    @providers = @user.credentials
    @other_providers = @user.other_providers
    # @all_providers = ["Instagram", "Github", "Vimeo", "developer"]

  end

  def user_is_current_user
    if params[:id].to_i != current_user.id
      redirect_to root_path, notice: "You may only edit your own account."
    end
  end
end
