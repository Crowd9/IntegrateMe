FactoryGirl.define do
  factory :setting do
    code { Setting::CODES.keys.sample }
    raw { {:a => 1}}
  end
end
