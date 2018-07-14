# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    url { 'image/upload/v1518298646/default.jpg' }
    book
  end
end
