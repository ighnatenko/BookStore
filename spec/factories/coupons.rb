# frozen_string_literal: true

FactoryBot.define do
  factory :coupon do
    code { "code-#{rand(1..10)}" }
    discount { rand(6..10) }
    order

    trait :invalid do
      code nil
    end

    trait :without_order do
      order nil
    end
  end
end
