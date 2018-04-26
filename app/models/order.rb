class Order < ApplicationRecord
  belongs_to :user, optional: true

  has_many :addresses, as: :addresable, dependent: :destroy
  has_one :credit_card, dependent: :destroy
  
  # accepts_nested_attributes_for :credit_card

  # %w[credit_card].each do |method|
  #   define_method method.to_sym do
  #     super() || public_send("build_#{method}")
  #   end
  # end
  private
  def set_confirmation_token
    if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
