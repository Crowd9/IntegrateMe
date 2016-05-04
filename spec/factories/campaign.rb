
FactoryGirl.define do
  factory :campaign do
    subject_line     { Faker::Superhero.name }
    title            { Faker::Name.title }
    from_name        { Faker::Name.name }
    reply_to         { Faker::Internet.email }
    api_key          { '8afcb0dcf3d1f3ecc4f35801703d8afb-us13' }
  end
end