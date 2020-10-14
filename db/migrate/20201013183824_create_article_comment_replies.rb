class CreateArticleCommentReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :article_comment_replies do |t|
      t.references :parent_article_comment, foreign_key: {to_table: :article_comments}
      t.references :children_article_comment, foreign_key: {to_table: :article_comments}

      t.timestamps
    end
  end
end
