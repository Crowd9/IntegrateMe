FactoryGirl.define do
  factory :competition do
    sequence(:name) { |n| "Competition ##{n}" }
  end
end
