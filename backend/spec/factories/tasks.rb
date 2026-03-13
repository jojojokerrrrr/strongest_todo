FactoryBot.define do
  factory :task do
    title { "task_name" }
    description { "task_description" }
    status { :incomplete }
    visibility { :public_task }
    association :user
    association :category

    trait :other_task do
      title { "other_task_name" }
      description { "other_task_description" }
      status { :incomplete }
      visibility { :private_task }
      association :user, :other_user
      association :category
    end
  end
end
