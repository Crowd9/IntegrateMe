FactoryGirl.define do
  factory :user do
    email "admin@test.com"
    password "Test:2017"
    password_confirmation "Test:2017"
  end
end
