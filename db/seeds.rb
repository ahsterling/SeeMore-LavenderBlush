# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# #
# # Examples:
# #
# #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   Mayor.create(name: 'Emanuel', city: cities.first)
#
# case Rails.env
# when "development"
#
#
#   feed_list = [
#     ["bookis", "Twitter", 8553052],
#     ["cuteemergency", "Twitter", 568825492],
#     ["fearlessideas", "Twitter", 84493112],
#     ["colemanfilm", "Vimeo", ]
#   ]
#
#   feed_list.each do |handle, provider, provider_uid|
#     Feed.create(handle: handle, provider: provider, provider_uid: provider_uid)
#     Post.create()
#   end
#
#   user_list = [
#     ["Veronica Mars", "veronica@mars.com"],
#     ["Fred Flintstone", "fred@bedrock.com"],
#     ["Buffy Summers", "buffy@sunnydale.com"],
#   ]
#
#   user_list.each do |name, email|
#     user = User.create(name: name, email: email)
#     Credential.create(user_id: user.id, provider: "Developer")
#   end
#
#   user_feed_list = [
#     [1, 1],
#     [2, 2],
#     [3, 3]
#   ]
#
#   user_feed_list.each do |user_id, feed_id|
#     UserFeed.create(user_id: user_id, feed_id: feed_id)
#   end
#
#
# fred = User.create(name: "fredflintstone", email: "fred@bedrock.com")
#
# feed1 = Feed.create(handle: "perolovkindgren", provider: "Vimeo")
# feed2 = Feed.create(handle: "user1557244", provider: "Vimeo")
# feed3 = Feed.create(handle: "sunflowertones" , provider: "Vimeo" )
#
# uf1 = UserFeed.create(user_id: fred.id, feed_id: feed1.id)
# uf2 = UserFeed.create(user_id: fred.id, feed_id: feed2.id)
# uf3 = UserFeed.create(user_id: fred.id, feed_id: feed3.id)
#
# def get_posts(feed)
#   if feed.provider == "Twitter"
#     client = Twitter::REST::Client.new do |config|
#       config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
#       config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
#       config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
#       config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
#     end
#     client.user_timeline(feed.provider_uid).each do |tweet|
#       Post.create(date: tweet.created_at, text_content: tweet.text, feed_id: feed.id)
#     end
#   elsif feed.provider == "Vimeo"
#     Vimeo::Simple::User.all_videos(feed.provider_uid).each do |video|
#       Post.create(
#         date: video["upload_date"],
#         text_content: video["title"],
#         media_url: video["url"],
#         feed_id: feed.id)
#     end
#   end
# end
# [uf1,uf2,uf3].each do |feed|
#   get_posts(feed)
# end
#
# end
