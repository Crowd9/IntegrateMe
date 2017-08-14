FactoryGirl.define do
  factory :competition_email_only, class: Competition do
    name 'Email only comp'
    requires_entry_name false
  end

  factory :competition_name_email, class: Competition do
    name 'Name+Email comp'
    requires_entry_name true
  end
end
