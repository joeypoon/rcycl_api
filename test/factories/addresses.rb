FactoryGirl.define do
  factory :address do
    user
    street { Faker::Address.street_address }
    unit_number { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip_code { Faker::Address.zip_code }
  end
end
