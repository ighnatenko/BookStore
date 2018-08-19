# frozen_string_literal: true

FactoryBot.define do
  factory :credit_card do
    number { Array.new(16) { rand(10) }.join }
    cvv { rand(111..999) }
    expiration_date { "#{rand(10..99)}/#{rand(10..99)}" }
    card_name { 'Test name' }
    order
  end
end
