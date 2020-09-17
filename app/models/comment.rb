class Comment < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_one :favorite, dependent: :destroy

  validates :text, presence: true, length: {maximum: 100}

end
