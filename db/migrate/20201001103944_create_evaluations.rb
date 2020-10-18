class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.integer :good, null: false, default: 0
      t.integer :bad, null: false, default: 0
      t.references :article, foreign_key: true
      t.references :article_comment, foreign_key: true
      t.references :user, foreign_key: true
      t.references :children_user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
