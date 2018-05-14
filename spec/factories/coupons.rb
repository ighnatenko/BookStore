FactoryBot.define do
  factory :coupon do
    code { Faker::Color.hex_code }
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