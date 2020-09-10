class Group < ApplicationRecord
  has_many :comments
  has_many :images
  accepts_nested_attributes_for :comments
  accepts_nested_attributes_for :images

  validates :title, presence: true, length: {maximum: 30}

end
