FactoryBot.define do
  factory :news do
    association :admin
    title {Faker::Name.name}
    content {Faker::Name.name}
  end
end
