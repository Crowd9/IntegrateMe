FactoryGirl.define do
  factory :entry, class: Entry do
    name Faker::Name.name
    email Faker::Internet.email
  end
end
