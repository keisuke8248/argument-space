class Comment < ApplicationRecord
  belongs_to :group

  validates :text, presence: true, length: {maximum: 100}

end
