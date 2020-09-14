class Group < ApplicationRecord
  has_many :comments
  has_many :group_images
  belongs_to :user
  accepts_nested_attributes_for :comments
  accepts_nested_attributes_for :group_images

  validates :title, presence: true, length: {maximum: 30}

end
