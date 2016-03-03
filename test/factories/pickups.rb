FactoryGirl.define do
  factory :pickup do
    user
    time Time.now
  end
end
