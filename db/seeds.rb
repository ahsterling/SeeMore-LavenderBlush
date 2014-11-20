# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

case Rails.env
when "development"


  feed_list = [
    ["bookis", "Twitter", 8553052],
    ["cuteemergency", "Twitter", 568825492],
    ["fearlessideas", "Twitter", 84493112],
    ["colemanfilm", "Vimeo", ]
  ]

  feed_list.each do |handle, provider, provider_uid|
    Feed.create(handle: handle, provider: provider, provider_uid: provider_uid)
    Post.create()
  end

  user_list = [
    ["Veronica Mars", "veronica@mars.com"],
    ["Fred Flintstone", "fred@bedrock.com"],
    ["Buffy Summers", "buffy@sunnydale.com"],
  ]

  user_list.each do |name, email|
    user = User.create(name: name, email: email)
    Credential.create(user_id: user.id, provider: "Developer")
  end

  user_feed_list = [
    [1, 1],
    [2, 2],
    [3, 3]
  ]

  user_feed_list.each do |user_id, feed_id|
    UserFeed.create(user_id: user_id, feed_id: feed_id)
  end
end

# fred = User.create(name: "fredflintstone", email: "fred@bedrock.com")
#
# feed1 = Feed.create(handle: "perolovkindgren", provider: "Vimeo")
# feed2 = Feed.create(handle: "user1557244", provider: "Vimeo")
# feed3 = Feed.create(handle: "sunflowertones" , provider: "Vimeo" )
#
# uf1 = UserFeed.create(user_id: fred.id, feed_id: feed1.id)
# uf2 = UserFeed.create(user_id: fred.id, feed_id: feed2.id)
# uf3 = UserFeed.create(user_id: fred.id, feed_id: feed3.id)
