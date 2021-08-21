# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    to_create(&:save)
    title { Faker::Book.title }
    content { Faker::Lorem.sentence }

    association :user

    after :create do |post|
      FactoryBot.create(:ip_address, post: post)
      FactoryBot.create(:rating, post: post)
    end
  end
end
