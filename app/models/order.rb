class Order < ApplicationRecord
  include AASM
  belongs_to :user, optional: true
  has_many :addresses, as: :addressable, dependent: :destroy
  has_one :credit_card, dependent: :destroy
  has_many :positions
  has_many :books, through: :positions
  
  validates :tracking_number, presence: true
  validates :state, presence: true

  scope :by_state, ->(state) { where(state: state) }

  aasm column: :state do
    state :in_progress, initial: true
    state :in_delivery
    state :delivered
    state :completed
    state :canceled

    event :in_progress do
      transitions from: :in_progress, to: :in_delivery
    end

    event :in_delivery do
      transitions from: :in_delivery, to: :delivered
    end

    event :delivered do
      transitions from: :delivered, to: :completed
    end

    event :cancel do
      transitions from: %i[in_progress in_delivery delivered completed], to: :canceled
    end
  end

  def self.aasm_states
    aasm.states.map(&:name)
  end

  def set_confirmation_token
    if self.confirmation_token.blank?
      self.confirmation_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
