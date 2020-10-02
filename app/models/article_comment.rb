class ArticleComment < ApplicationRecord
  belongs_to :article
  has_many :evaluations, dependent: :destroy

end
