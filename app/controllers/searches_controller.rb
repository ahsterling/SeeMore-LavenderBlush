class SearchesController < ApplicationController

  rescue_from Twitter::Error::BadRequest, with: :empty_query
  before_action :logged_in?

  def index

  end

  def results                           # @results is assigned in either twitter_search or vimeo_search
    @user = User.find(session[:user_id])
    @provider = params[:provider]
    if @provider == "Twitter"
      twitter_search
      add_bookis
    elsif @provider == "Vimeo"
      vimeo_search
      add_bookis
    else
      redirect_to search_path
    end
  end


  private

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
    end
  end

  def twitter_search
    client = twitter_client
    # username is the variable twitter uses to represent the twitter handle
    # for their searches. user_search is a twitter method
    @results = client.user_search(params[:username], { count: 10 })
  end

  def vimeo_search
    beemos = Beemo::User.search(params[:username].gsub(/\s+/,""))
    @results = []
    beemos.each do |beemo|
      @results << Vimeo::Simple::User.info(beemo.uid)
    end
  end

  def add_bookis
    if @results.empty?
      @bookis = twitter_client.user(8553052)
    end
  end

  def empty_query
    redirect_to search_path
  end
end
