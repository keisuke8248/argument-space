class Evaluation < ApplicationRecord
  belongs_to :article_comment
  belongs_to :user
  belongs_to :article

  def self.evaluate(key, user_id, children_id, article_id, comment_id)
    evaluation = self.find_by(user_id: user_id,
                                    article_id: article_id,
                                    article_comment_id: comment_id)
    if evaluation.blank? && comment_id != user_id
      evaluation = self.new(user_id: user_id,
                                  article_id: article_id,
                                  article_comment_id: comment_id,
                                  children_user_id: children_id
                                  )
      evaluation.save!
      evaluation.increment!(key, 1)
    end
  end

  def self.canceling_evaluate(user_id, article_id, comment_id)
    evaluation = self.find_by(user_id: user_id,
                              article_id: article_id,
                              article_comment_id: comment_id)
    evaluation.destroy
  end
end
