class ArticleComment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  has_many :evaluations, dependent: :destroy
  has_many :article_comment_replies

  validates :index, uniqueness: true

end
