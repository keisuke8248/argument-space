class Comment < ApplicationRecord
  belongs_to :group

  #accepts_nested_attributes_for :comment_images

  validates :text, presence: true, length: {maximum: 100}

end
