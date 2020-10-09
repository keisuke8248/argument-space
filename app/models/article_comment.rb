class ArticleComment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  has_many :evaluations, dependent: :destroy

end
