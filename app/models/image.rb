class Image < ApplicationRecord
  belongs_to :comment
  belongs_to :group

  mount_uploader :src, ImageUploader
end
