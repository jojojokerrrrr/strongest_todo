FactoryBot.define do
  factory :user do
    name { "user_name" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "123456" }

    trait :other_user do
      name { "other_name" }
      sequence(:email) { |n| "other#{n}@example.com" }
      password { "other_123456" }
    end
  end
end
