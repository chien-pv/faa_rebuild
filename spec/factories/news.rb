FactoryBot.define do
  factory :news do
    association :admin
    title {Faker::String.random(1..10)}
    content {Faker::Number.between(1, 5)}
  end
end
