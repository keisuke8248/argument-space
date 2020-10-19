class ArticleComment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  has_many :evaluations, dependent: :destroy
  has_many :article_comment_replies

  validates :index, uniqueness: true

  def self.searchAnchor(i)
    if />>#{i}[^\d]/.match(self)
      return i
    end
  end

end
