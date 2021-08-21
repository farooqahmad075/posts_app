# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    to_create(&:save)

    username { Faker::Internet.unique.username(specifier: 3..25) }

    initialize_with { User.find_or_create(username: username) }
  end
end
