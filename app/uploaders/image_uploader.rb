# frozen_string_literal: true

# ImageUploader
class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick

  def extension_whitelist
    %w[jpg jpeg png]
  end
end
