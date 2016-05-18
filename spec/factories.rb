FactoryGirl.define do
  factory :exchange do
  end

  factory :coin do
    association :exchange
    value 2
    count 10
  end
end
