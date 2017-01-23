require "faker"

FactoryGirl.define do
  factory :comment do
    content {Faker::Lorem.sentence}
    user_id 1
    product_id 2
  end
end
