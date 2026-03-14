FactoryBot.define do
  factory :task do
    title { "task_name" }
    description { "task_description" }
    status { :incomplete }
    association :user
    association :category

    trait :other_task do
      title { "other_task_name" }
      description { "other_task_description" }
      status { :incomplete }
      association :user, :other_user
      association :category
    end
  end
end
