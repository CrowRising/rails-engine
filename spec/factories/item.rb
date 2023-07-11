# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    unit_price { Faker::Number.within(range: 1..50) }
    association :merchant, factory: :merchant
  end
end
