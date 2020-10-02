class Evaluation < ApplicationRecord
  belongs_to :article_comment
  belongs_to :user
  belongs_to :article


end
