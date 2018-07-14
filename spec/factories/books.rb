# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    description { Faker::StarWars.wookiee_sentence }
    price { rand(5..300) }
    width { rand(5..30) }
    height { rand(5..30) }
    depth { rand(5..30) }
    publication_year { rand(1970..2018) }
    materials { Faker::StarWars.planet }
    quantity { rand(5..50) }
    category
  end
end
