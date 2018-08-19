# frozen_string_literal: true

# Review
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :description, :rating, presence: true
end
