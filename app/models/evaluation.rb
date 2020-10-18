class Evaluation < ApplicationRecord
  belongs_to :article_comment
  belongs_to :user
  belongs_to :article

  def self.evaluate(key1, key2, user_id, article_id, comment_id, current_user_id)
    evaluation = self.find_by(user_id: user_id,
                                    article_id: article_id,
                                    article_comment_id: comment_id)
    if evaluation.blank? && comment_id != current_user_id
      evaluation = self.new(user_id: user_id,
                                  article_id: article_id,
                                  article_comment_id: comment_id,
                                  
                                  )
      evaluation.save!
      evaluation.increment!(key1, 1)
    end
  end

  def self.canceling_evaluate(user_id, article_id, comment_id)
    evaluation = self.find_by(user_id: user_id,
                              article_id: article_id,
                              article_comment_id: comment_id)
    evaluation.destroy
  end
end
