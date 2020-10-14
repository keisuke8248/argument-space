class ArticleCommentReply < ApplicationRecord
  belongs_to :article_comment, optional: true
end
