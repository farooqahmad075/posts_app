# frozen_string_literal: true

FactoryBot.define do
  factory :feedback do
    to_create(&:save)
    comment { Faker::Lorem.sentence }
    owner { FactoryBot.create(:user) }

    trait :user_feedback do
      feedbackable { FactoryBot.create(:user) }
    end
    trait :post_feedback do
      feedbackable { FactoryBot.create(:post) }
    end
  end
end
