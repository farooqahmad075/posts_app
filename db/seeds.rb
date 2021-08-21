# frozen_string_literal: true

require 'faker'
require 'httparty'

# 50 different IP addresses.
ipv4_addresses_pool = []
50.times.each { ipv4_addresses_pool << Faker::Internet.public_ip_v4_address }

# 200k Posts, 2000 authers, each with atleast 100 posts.
2000.times.each do
  username = Faker::Internet.unique.username(specifier: 3..25)
  100.times.each do
    params = {
      title: Faker::Book.title,
      content: Faker::Lorem.sentence,
      auther: {
        username: username,
        ip: ipv4_addresses_pool.sample(1).join
      }
    }

    HTTParty.post("#{ENV['SERVER_URL']}/api/v1/posts", body: params)
  end
end

# 10k Post Feedbacks, 100 User Feedbacks.
last_user = User.last

User.first(100).each do |user|
  Post.first(100).each do |post|
    params = {
      post_id: post.id,
      comment: Faker::Lorem.sentence,
      owner_id: user.id
    }

    HTTParty.post("#{ENV['SERVER_URL']}/api/v1/feedbacks", body: params)
  end

  params = {
    user_id: last_user.id,
    comment: Faker::Lorem.sentence,
    owner_id: user.id
  }

  HTTParty.post("#{ENV['SERVER_URL']}/api/v1/feedbacks", body: params)
end
