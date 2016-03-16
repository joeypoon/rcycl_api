FactoryGirl.define do
  factory :subscriber do
    email { Faker::Internet.email }
    zip_code { Faker::Address.zip_code }
  end
end
