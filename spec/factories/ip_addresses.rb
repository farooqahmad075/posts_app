# frozen_string_literal: true

FactoryBot.define do
  factory :ip_address do
    to_create(&:save)
    ip { Faker::Internet.public_ip_v4_address }
    post
  end
end
