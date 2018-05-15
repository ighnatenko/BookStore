FactoryBot.define do
  factory :review do
    rating { rand(1..10) }
    description { Faker::StarWars.wookiee_sentence }
    book
    user
  end
end