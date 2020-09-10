class Comment < ApplicationRecord
  belongs_to :group, inverse_of: :comments
  has_many :images

  validates :text, presence: true, length: {maximum: 100}

end
