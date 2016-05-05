
# => Competition(id: integer, name: string, requires_entry_name: boolean, created_at: datetime, updated_at: datetime)

FactoryGirl.define do
  factory :competition do
    name        { Faker::Name.title }
    requires_entry_name       { true }
  end
end