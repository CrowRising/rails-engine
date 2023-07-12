# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    customer_id { create(:customer).id }
    merchant_id { create(:merchant).id }
    status { '204' }
  end
end

