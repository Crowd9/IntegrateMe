FactoryBot.define do
  factory :entry do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    competition
  end
end
