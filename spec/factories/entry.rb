
# => Entry(id: integer, competition_id: integer, name: text, email: text, created_at: datetime, updated_at: datetime)

FactoryGirl.define do
  factory :entry do
    name        { Faker::Name.name }
    email       { Faker::Internet.email }
    competition
  end
end