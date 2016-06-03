FactoryGirl.define do
  factory :competition do
    sequence(:name) { |n| "the best figther in the galaxy ##{n}" }
    sequence(:runner_email) { |n| "chewy-#{n}@example.com" }
    requires_entry_name false
    mail_chimp_api_key 'test-api-key'
    mail_chimp_list_id 'test-list-id'
  end
end
