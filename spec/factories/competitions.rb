FactoryBot.define do
  factory :competition do
    name { Faker::Lorem.sentence }
    requires_entry_name { Faker::Boolean.boolean }
  end
end
