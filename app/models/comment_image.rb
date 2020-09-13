class CommentImage < ApplicationRecord
  belongs_to :comments
  mount_uploader :src, ImageUploader
end
