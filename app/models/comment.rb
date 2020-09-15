class Comment < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :favorites

  validates :text, presence: true, length: {maximum: 100}

end
