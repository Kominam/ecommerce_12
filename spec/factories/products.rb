FactoryGirl.define do
  factory :product do
    name {Faker::Commerce.product_name}
    description {Faker::Lorem.sentence}
    price {Faker::Number.number(3)}
    in_stock {Faker::Number.number(1)}
    category_id 1
  end
end
