class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick

  version :thumb do
    process resize_to_fit: [50, 50]
  end

  def extension_whitelist
    %w[jpg jpeg png]
  end
end
