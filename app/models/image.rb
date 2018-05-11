class Image < ApplicationRecord
  belongs_to :book
  validates :url, presence: true
  mount_uploader :url, ImageUploader
end