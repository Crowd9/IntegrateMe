FactoryGirl.define do
  factory :integration do
    name { Faker::Name.name }
    api_key { Faker::Lorem.characters(32) }
    api_token { Faker::Lorem.characters(255) }

    factory :mailchimp, class: 'MailchimpApi' do
      api_key { '717008e14da769db801baac65aaa24c6-us12' }
      api_token { nil }
    end
  end
end
