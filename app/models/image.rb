class Image < ApplicationRecord
  belongs_to :comment, inverse_of: :images
  belongs_to :group, inverse_of: :images

  mount_uploader :image, ImageUploader
end
