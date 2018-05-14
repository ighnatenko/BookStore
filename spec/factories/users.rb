FactoryBot.define do
  factory :user do
    after(:build, &:skip_confirmation_notification!)
    after(:create, &:confirm)

    sequence :email do |n|
      "person#{n}@example.com"
    end
    
    password '123456'
    password_confirmation '123456'
    admin true
  end
end