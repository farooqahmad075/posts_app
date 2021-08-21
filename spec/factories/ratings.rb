# frozen_string_literal: true

FactoryBot.define do
  factory :rating do
    to_create(&:save)
    value { Faker::Number.between(from: 1, to: 5) }
    post
  end
end
