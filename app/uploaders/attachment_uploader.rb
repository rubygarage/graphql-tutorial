class AttachmentUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/attachment/#{mounted_as}/#{model.id}"
  end

  def asset_host
    'http://localhost:3000'
  end
end
