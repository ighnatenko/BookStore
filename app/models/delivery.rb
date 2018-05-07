class Delivery < ApplicationRecord
  has_many :orders, dependent: :nullify
  validates :title, :days, :price, presence: true
end
