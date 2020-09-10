class GroupImage < ApplicationRecord
  belongs_to :group
  mount_uploader :src, ImageUploader

end
