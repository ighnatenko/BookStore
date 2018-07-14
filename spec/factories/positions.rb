# frozen_string_literal: true

FactoryBot.define do
  factory :position do
    quantity { rand(10..20) }
    order
    book
  end
end
