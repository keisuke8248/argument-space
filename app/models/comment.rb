class Comment < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :text, presence: true, length: {maximum: 100}

end
