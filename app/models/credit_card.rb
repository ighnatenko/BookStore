class CreditCard < ApplicationRecord
  CVV_REGEXP = /\A\d{3}\z/
  NUMBER_REGEXP = /\A\d{16}\z/
  EXIRATION_DATE_REGEXP = /\A(\d{2})\/(\d{2})\z/
  CARD_NAME_REGEXP = /[a-zA-Z]/

  belongs_to :cardable, polymorphic: true

  validates :number, :cvv, :expiration_date, :card_name, presence: true
  validates :number, format: { with: NUMBER_REGEXP }
  validates :cvv, format: { with: CVV_REGEXP }
  validates :expiration_date, format: { with: EXIRATION_DATE_REGEXP }
  validates :card_name, format: { with: CARD_NAME_REGEXP }
end
