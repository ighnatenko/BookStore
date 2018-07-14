# frozen_string_literal: true

FactoryBot.define do
  factory :delivery do
    title { Faker::Book.title }
    days { 'test' }
    price { rand(10...20) }
  end
end
