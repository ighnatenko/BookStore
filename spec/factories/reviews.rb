# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    rating { rand(1..5) }
    description { Faker::StarWars.wookiee_sentence }
    book
    user
  end
end
