# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


fred = User.create(name: "fredflintstone", email: "fred@bedrock.com")

feed1 = Feed.create(handle: "perolovkindgren", provider: "Vimeo")
feed2 = Feed.create(handle: "user1557244", provider: "Vimeo")
feed3 = Feed.create(handle: "sunflowertones" , provider: "Vimeo" )

uf1 = UserFeed.create(user_id: fred.id, feed_id: feed1.id)
uf2 = UserFeed.create(user_id: fred.id, feed_id: feed2.id)
uf3 = UserFeed.create(user_id: fred.id, feed_id: feed3.id)
