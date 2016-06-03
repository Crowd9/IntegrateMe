FactoryGirl.define do
  factory :entry do
    competition
    sequence(:email) { |n| "luke#{n}@example.com" }
    sequence(:name) { |n| "Luke ##{n}" }
  end
end
