class Address < ApplicationRecord
  validates :firstname, :lastname, :address, :zipcode,
            :city, :country, :phone, presence: true

  belongs_to :addressable, polymorphic: true
end
