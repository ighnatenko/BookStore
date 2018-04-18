class Address < ApplicationRecord
  validates :firstname, :lastname, :address, :zipcode,
            :city, :country, :phone, :address_type, presence: true

  belongs_to :addresable, polymorphic: true

  enum address_type: %i[billing shipping]
end
