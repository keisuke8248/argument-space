class Comment < ApplicationRecord
  belongs_to :group
  has_many :comment_images

  accepts_nested_attributes_for :comment_images

  validates :text, presence: true, length: {maximum: 100}

end
