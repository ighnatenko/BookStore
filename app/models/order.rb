class Order < ApplicationRecord
  include AASM
  belongs_to :user, optional: true
  has_many :addresses, as: :addressable, dependent: :destroy
  has_one :credit_card, as: :cardable, dependent: :destroy
  has_many :positions
  has_many :books, through: :positions, dependent: :destroy
  belongs_to :delivery, optional: true
  has_one :coupon

  validates :tracking_number, presence: true
  validates :state, presence: true
  
  scope :by_state, ->(state) { where(state: state) }

  aasm column: :state do
    state :in_progress, initial: true
    state :in_delivery, after_enter: :send_confirmation
    state :delivered

    event :deliver do
      transitions from: :in_progress, to: :in_delivery
    end

    event :completed do
      transitions from: :in_delivery, to: :delivered
    end
  end

  def self.aasm_states
    aasm.states.map(&:name)
  end

  def set_confirmation_token
    if self.confirmation_token.blank?
      self.confirmation_token = SecureRandom.urlsafe_base64.to_s
      self.save(validate: false)
    end
  end

  def send_confirmation
    set_confirmation_token
    OrderMailer.order_confirmation(self).deliver_now
    redirect_to root_path, notice: "Please confirm your order to continue"
  end
end