
FactoryGirl.define do
  factory :campaign do
    subject_line     { Faker::Superhero.name }
    title            { Faker::Name.title }
    from_name        { Faker::Name.name }
    reply_to         { Faker::Internet.email }
    api_key          { Faker::Internet.password(10, 20) }
  end
end