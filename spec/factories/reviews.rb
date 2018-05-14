FactoryBot.define do
  factory :review do
    rating { rand(1..10) }
    description { Faker::Tweet.body }
    book
    user
  end
end