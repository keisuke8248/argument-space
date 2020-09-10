class Group < ApplicationRecord
  has_many :comments, inverse_of: :group
  has_many :images, inverse_of: :group
  accepts_nested_attributes_for :comments
  accepts_nested_attributes_for :images

  validates :title, presence: true, length: {maximum: 30}

end
