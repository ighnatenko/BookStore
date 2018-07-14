# frozen_string_literal: true

class Coupon < ApplicationRecord
  belongs_to :order, optional: true
  validates :code, :discount, presence: true
  validates :code, length: { in: 6..10 }
end
