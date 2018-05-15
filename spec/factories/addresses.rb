FactoryBot.define do
  factory :address do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    address { Faker::Address.street_name }
    city { Faker::Address.city }
    zipcode { Faker::Address.zip_code }
    country { Faker::Address.country }
    phone { Faker::PhoneNumber.phone_number }

    trait :shipping do
      address_type :shipping
    end

    trait :billing do
      address_type :billing
    end

    trait :invalid do
      zipcode nil
    end
  end
end