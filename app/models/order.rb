class Order < ApplicationRecord
  belongs_to :user, optional: true

  has_many :addresses, as: :addressable
  has_one :credit_card
  
  accepts_nested_attributes_for :credit_card

  %w[credit_card].each do |method|
    define_method method.to_sym do
      super() || public_send("build_#{method}")
    end
  end
end
