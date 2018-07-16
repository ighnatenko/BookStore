# frozen_string_literal: true

# Position
class Position < ApplicationRecord
  belongs_to :book
  belongs_to :order
  validates :quantity, presence: true
end
