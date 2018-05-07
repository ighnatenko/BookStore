class Category < ApplicationRecord
  has_many :books, dependent: :delete_all
  validates :title, presence: true, uniqueness: true
end