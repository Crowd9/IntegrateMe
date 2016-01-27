FactoryGirl.define do
  sequence :email do |n|
    "entry#{n}@yahoo.com"
  end
end

FactoryGirl.define do
  factory :entry do
    competition
    email {generate(:email)}
    name {Faker::Name.name}
  end
end
